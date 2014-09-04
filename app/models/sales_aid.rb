class SalesAid < ActiveRecord::Base
  belongs_to :user

  CATEGORIES = {presentation: :document, literature: :document, calculator: :link, newsletter: :document, video: :video}
  ACCESS_LEVELS = {guest: 0, public_sales: 1, biozyme: 2}

  enum access_level: ACCESS_LEVELS
  store :video_data, accessors: [:name, :summary, :thumbnail_url, :large_thumbnail_url]
  mount_uploader :document, SalesAidUploader
  acts_as_list scope: [:category]

  validates :title,        presence: true
  validates :category,     presence: true,
                           inclusion: { in: CATEGORIES.keys.map(&:to_s) }
  validates :user_id,      presence: true
  validates :access_level, presence: true
  validates :video_id,     presence: { if: lambda { |s| s.video? } }
  validates :link,         presence: { if: lambda { |s| s.external_link? } },
                           format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix, allow_nil: true }

  before_save :set_metadata

  def type
    CATEGORIES.with_indifferent_access[category]
  end

  def filename
    document.path.split('/').last
  end

  def file_extension
    filename.split('.').last.to_sym
  end

  def external_link?
    type == :link
  end

  def video?
    type == :video
  end

  def get_video
    youtube_client = YouTubeIt::Client.new
    youtube_client.video_by(video_id)
  rescue
    nil
  end

  private

  def set_metadata
    if document.present? && document_changed?
      self.document_size = document.file.size
      self.document_content_type = document.file.content_type
    end

    if video? && v = get_video
      self.name = v.title
      self.summary = v.description
      self.thumbnail_url = v.thumbnails[0].url
      self.large_thumbnail_url = v.thumbnails[1].url
    end
  end
end
