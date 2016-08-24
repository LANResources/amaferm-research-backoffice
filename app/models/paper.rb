class Paper < ActiveRecord::Base
  self.primary_key = :source_id

  belongs_to :author
  has_many :trials, dependent: :destroy
  has_many :supplementals, dependent: :destroy

  include Filterable
  include FileDataManagement

  LITERATURE_TYPES = [
    "Abstract", 
    "Book", 
    "Controlled Field Trial", 
    "Dissertation", 
    "Final Report", 
    "Journal Article", 
    "Proceedings & Bulletins",
    "Thesis"
  ]

  mount_uploader :document, DocumentUploader
  
  attr_accessor :author_name
  accepts_nested_attributes_for :trials
  
  validates :author_id, presence: true
  validates :citation, presence: true
  
  validates :literature_type, inclusion: { in: LITERATURE_TYPES }

  before_save :normalize_values
  after_commit :flush_cache

  def self.cached_journals
    Rails.cache.fetch([name, 'journals']){ pluck(:journal).uniq.compact.sort }
  end

  scope :for_author,      -> (author)  { where(author_id: author) }
  scope :for_journal,     -> (journal) { where(journal: journal) }

  def author_name
    author.try(:last_name)
  end

  def formatted_citation
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(citation).html_safe
  end

  def self.cached_all_for_select
    Rails.cache.fetch [self, 'all-for-select'] do
      Struct.new 'PaperForSelect', :id, :display
      order(:source_id).to_a.map do |p|
        Struct::PaperForSelect.new p.source_id, [p.source_id, p.title.truncate(80, separator: ' ')].join(' - ')
      end
    end
  end

  private

  def normalize_values
    self.journal = nil if journal.blank?
  end

  def flush_cache
    Rails.cache.delete([self.class.name, 'journals'])
    Rails.cache.delete([self.class.name, 'all-for-select'])
    Rails.cache.delete(['Author', 'having-papers'])
    Rails.cache.delete(['Author', 'names-having-papers'])
  end
end
