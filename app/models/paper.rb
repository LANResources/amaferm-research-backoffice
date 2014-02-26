class Paper < ActiveRecord::Base
  self.primary_key = :source_id

  belongs_to :author

  include Filterable

  LEVELS = [:basic, :biozyme]
  LITERATURE_TYPES = [
    "Abstract", 
    "Book", 
    "Controlled Field Trial", 
    "Dissertation", 
    "Final Report", 
    "Journal Article", 
    "Proceedings & Bulletins"
  ]

  enum level: LEVELS
  mount_uploader :document, DocumentUploader
  acts_as_taggable_on :species, :focus

  attr_accessor :author_name

  validates :author_id, presence: true
  validates :citation, presence: true
  validates :year, presence: true
  validates :literature_type, inclusion: { in: LITERATURE_TYPES }

  before_save :normalize_values

  def self.species
    ActsAsTaggableOn::Tagging.joins(:tag).where(context: 'species').pluck(:name).uniq.sort
  end

  def self.focuses
    ActsAsTaggableOn::Tagging.joins(:tag).where(context: 'focus').pluck(:name).uniq.sort
  end

  def self.journals
    pluck(:journal).uniq.compact.sort
  end

  scope :for_species,     -> (species) { tagged_with(species, on: :species) }
  scope :for_any_species, -> (species) { tagged_with(species, on: :species, any: true) }
  scope :for_focus,       -> (focus)   { tagged_with(focus, on: :focus) }
  scope :for_any_focus,   -> (focus)   { tagged_with(focus, on: :focus, any: true) }
  scope :for_author,      -> (author)  { where(author_id: author) }
  scope :for_journal,     -> (journal) { where(journal: journal) }

  def author_name
    author.try(:last_name)
  end

  def filename
    document.path.split('/').last
  end

  def formatted_citation
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(citation).html_safe
  end

  private

  def normalize_values
    self.journal = nil if journal.blank?
  end
end
