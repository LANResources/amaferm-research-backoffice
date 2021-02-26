class SalesAid < ActiveRecord::Base
  belongs_to :user

  CATEGORIES = {presentation: :document, literature: :document, document: :document, calculator: :link, newsletter: :document, video: :video}
  ACCESS_LEVELS = {guest: 0, public_sales: 1, biozyme: 2, _private: 3}

  include FileDataManagement

  enum access_level: ACCESS_LEVELS
  store :video_data, accessors: [:name, :summary, :thumbnail_url, :large_thumbnail_url]
  mount_uploader :document, SalesAidUploader
  acts_as_list scope: [:category]

  validates :title,        presence: true
  validates :category,     presence: true,
                           inclusion: { in: CATEGORIES.keys.map(&:to_s) }
  validates :user_id,      presence: true
  validates :access_level, presence: true
  validates :document,     presence: { if: lambda { |s| type == :document } }
  validates :video_id,     presence: { if: lambda { |s| s.video? } }
  validates :link,         presence: { if: lambda { |s| s.external_link? } },
                           format: {
                            with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix,
                            allow_nil: true,
                            if: lambda { |s| s.external_link? }
                           }

  scope :for_country, -> (country) { where("?::text = ANY (country_codes)", country) if country.present? }
  scope :with_country_names, -> { select("ARRAY(SELECT name FROM countries WHERE countries.country_code = ANY (sales_aids.country_codes)) AS country_names") }

  before_save :set_video_metadata, :normalize_country_codes
  after_commit :flush_cache

  def self.countries
    Country.where(country_code: pluck(:country_codes).flatten.uniq).order(name: :asc).to_a
  end

  def self.cached_countries
    Rails.cache.fetch([name, 'countries']){ countries }
  end

  def type
    CATEGORIES.with_indifferent_access[category]
  end

  def external_link?
    type == :link
  end

  def video?
    type == :video
  end

  def get_video
    Yt::Video.new id: video_id
  rescue
    nil
  end

  def countries
    Rails.cache.fetch([self, 'countries']){ Array(country_codes).any? ? Country.where(country_code: country_codes).to_a : [] }
  end

  private

  def set_video_metadata
    if video? && v = get_video
      self.name = v.title
      self.summary = v.description
      self.thumbnail_url = v.thumbnail_url
      self.large_thumbnail_url = v.thumbnail_url
    end
  rescue => e
    ExceptionNotifier.notify_exception e, data: { video_id: id, youtube_id: youtube_id }
  end

  def normalize_country_codes
    self.country_codes = Array(country_codes).reject(&:blank?).uniq
  end

  def flush_cache
    Rails.cache.delete([self.class.name, 'countries'])
  end
end
