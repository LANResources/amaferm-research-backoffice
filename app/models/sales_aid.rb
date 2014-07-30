class SalesAid < ActiveRecord::Base
  belongs_to :user

  CATEGORIES = %w[presentation literature calculator newsletter video]
  ACCESS_LEVELS = {guest: 0, public_sales: 1, biozyme: 2}
  
  enum access_level: ACCESS_LEVELS
  store :video_data, accessors: [:name, :summary, :thumbnail_url, :large_thumbnail_url]
  mount_uploader :document, SalesAidUploader
  acts_as_list scope: [:category]

  validates :title,        presence: true
  validates :category,     presence: true, 
                           inclusion: { in: CATEGORIES }
  validates :user_id,      presence: true
  validates :access_level, presence: true
  validates :video_id,     presence: { if: lambda { |s| s.video? } }

  before_save :set_metadata
  
  def filename
    document.path.split('/').last
  end

  def file_extension
    filename.split('.').last.to_sym
  end

  def video?
    category == 'video'
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
