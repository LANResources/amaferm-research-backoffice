class SalesAid < ActiveRecord::Base
  belongs_to :user

  CATEGORIES = %w[presentation literature calculator]
  ACCESS_LEVELS = {guest: 0, public_sales: 1, biozyme: 2}
  
  enum access_level: ACCESS_LEVELS
  mount_uploader :document, SalesAidUploader

  validates :title,        presence: true
  validates :category,     presence: true, 
                           inclusion: { in: CATEGORIES }
  validates :user_id,      presence: true
  validates :access_level, presence: true

  before_save :set_metadata
  
  def filename
    document.path.split('/').last
  end

  def file_extension
    filename.split('.').last.to_sym
  end

  private

  def set_metadata
    if document.present? && document_changed?
      self.document_size = document.file.size
      self.document_content_type = document.file.content_type
    end
  end
end
