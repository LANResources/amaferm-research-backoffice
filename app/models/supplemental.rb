class Supplemental < ActiveRecord::Base
  belongs_to :paper
  belongs_to :author

  LEVELS = {web: 0, shared: 2, biozyme: 1}
  enum level: LEVELS

  mount_uploader :document, DocumentUploader
  
  attr_accessor :author_name
  LITERATURE_TYPES = Paper::LITERATURE_TYPES + [
    'Correction',
    'Data',
    'Internal Review'
  ]

  # Validations
  validates :source_sub_id, presence: true,
                            uniqueness: { scope: :paper_id },
                            numericality: { only_integer: true, greater_than: 0 }
  validates :year,  presence: true,
                    numericality: { only_integer: true }
  validates :title,     presence: true
  validates :author_id, presence: true
  validates :citation,  presence: true
  validates :literature_type, inclusion: { in: LITERATURE_TYPES }

  # Callbacks
  after_initialize :set_default_source_sub_id
  before_save :set_metadata

  # Scopes
  scope :with_paper_and_author, -> { joins(paper: :author) }

  def self.find(input)
    if /\A(?<paper_id>\d+)\.(?<source_sub_id>\d+)\z/ =~ input.to_s
      where(paper_id: paper_id.to_i, source_sub_id: source_sub_id.to_i).first
    else
      super
    end
  end

  def to_param
    complete_source_id
  end

  def complete_source_id
    [paper_id, source_sub_id].join '.'
  end

  def author_name
    author.try(:last_name)
  end

  def formatted_citation
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(citation).html_safe
  end

  def filename
    document.path.split('/').last
  end

  def file_extension
    filename.split('.').last.to_sym
  end

  private

  def set_default_source_sub_id
    self.source_sub_id ||= Supplemental.where(paper_id: paper_id).maximum(:source_sub_id).try(:succ) || 1
  end

  def set_metadata
    if document.present? && document_changed?
      self.document_size = document.file.size
      self.document_content_type = document.file.content_type
    end
  end
end
