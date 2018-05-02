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

  before_save :set_video_metadata

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

  private

  def set_video_metadata
    if video? && v = get_video
      self.name = v.title
      self.summary = v.description
      self.thumbnail_url = v.thumbnail_url
      self.large_thumbnail_url = v.thumbnail_url
    end
  end
end
