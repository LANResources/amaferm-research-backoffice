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
  after_commit :flush_cache

  def self.cached_species
    Rails.cache.fetch([name, 'species']) do 
      ActsAsTaggableOn::Tagging.joins(:tag).where(context: 'species').pluck(:name).uniq.sort
    end
  end

  def self.cached_focuses
    Rails.cache.fetch([name, 'focuses']) do
      ActsAsTaggableOn::Tagging.joins(:tag).where(context: 'focus').pluck(:name).uniq.sort
    end
  end

  def self.cached_years
    Rails.cache.fetch([name, 'years']){ pluck(:year).uniq.sort }
  end

  def self.cached_journals
    Rails.cache.fetch([name, 'journals']){ pluck(:journal).uniq.compact.sort }
  end

  def cached_species_list
    Rails.cache.fetch([self, 'species-list']){ species_list }
  end

  def cached_focus_list
    Rails.cache.fetch([self, 'focus-list']){ focus_list }
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

  def flush_cache
    Rails.cache.delete([self.class.name, 'years'])
    Rails.cache.delete([self.class.name, 'journals'])
    Rails.cache.delete([self.class.name, 'species'])
    Rails.cache.delete([self.class.name, 'focuses'])
    Rails.cache.delete([self, 'species-list'])
    Rails.cache.delete([self, 'focus-list'])
  end
end
