class PaperSummary < ActiveRecord::Base
  belongs_to :trial

  SPECIES = ['Dairy', 'Beef', 'Poultry', 'Swine', 'Equine', 'Multi-Species', 'Aqua', 'Pet', 'Specialty']

  mount_uploader :document, DocumentUploader
  acts_as_list scope: [:species]

  validates :title, presence: true
  validates :description, presence: true
  validates :species, presence: true, inclusion: { in: SPECIES }

  before_save :set_metadata
  
  scope :featured, -> { where(featured: true) }

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
