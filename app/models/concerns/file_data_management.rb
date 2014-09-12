module FileDataManagement
  extend ActiveSupport::Concern

  included do
    before_save :set_metadata
  end

  def filename
    document.path.split('/').last
  end
  
  def file_extension
    filename.split('.').last.to_sym
  end

  def set_metadata
    if document.present? && document_changed?
      self.document_size = document.file.size
      self.document_content_type = document.file.content_type
    end
  end
end