class Paper < ActiveRecord::Base
  self.primary_key = :source_id

  belongs_to :author
  has_many :trials, dependent: :destroy

  include Filterable

  LITERATURE_TYPES = [
    "Abstract", 
    "Book", 
    "Controlled Field Trial", 
    "Dissertation", 
    "Final Report", 
    "Journal Article", 
    "Proceedings & Bulletins"
  ]

  mount_uploader :document, DocumentUploader
  
  attr_accessor :author_name
  accepts_nested_attributes_for :trials
  
  validates :author_id, presence: true
  validates :citation, presence: true
  
  validates :literature_type, inclusion: { in: LITERATURE_TYPES }

  before_save :normalize_values, :set_metadata
  after_commit :flush_cache

  def self.cached_journals
    Rails.cache.fetch([name, 'journals']){ pluck(:journal).uniq.compact.sort }
  end

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

  def set_metadata
    if document.present? && document_changed?
      self.document_size = document.file.size
      self.document_content_type = document.file.content_type
    end
  end

  def flush_cache
    Rails.cache.delete([self.class.name, 'journals'])
  end
end
