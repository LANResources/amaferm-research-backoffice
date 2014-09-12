class PaperSummary < ActiveRecord::Base
  belongs_to :trial

  SPECIES = ['Dairy', 'Beef', 'Poultry', 'Swine', 'Equine', 'Multi-Species', 'Aqua', 'Pet', 'Specialty']

  include FileDataManagement

  mount_uploader :document, DocumentUploader
  acts_as_list scope: [:species]

  validates :title, presence: true
  validates :description, presence: true
  validates :species, presence: true, inclusion: { in: SPECIES }
  
  scope :featured, -> { where(featured: true) }
end
