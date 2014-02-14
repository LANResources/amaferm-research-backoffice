class Paper < ActiveRecord::Base
  self.primary_key = :source_id

  belongs_to :author

  LEVELS = [:basic, :biozyme]

  enum level: LEVELS
  mount_uploader :document, DocumentUploader

  validates :author_id, presence: true
  validates :citation, presence: true
  validates :year, presence: true
end
