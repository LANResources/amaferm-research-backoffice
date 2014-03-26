class Trial < ActiveRecord::Base
  belongs_to :paper
  has_many :performance_measures, dependent: :destroy

  include Filterable

  LEVELS = {web: 0, shared: 2, biozyme: 1}
  enum level: LEVELS

  validates :source_sub_id, presence: true,
                            uniqueness: { scope: :paper_id, case_sensitive: false },
                            format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :year, presence: true
  acts_as_taggable_on :species, :focus

  after_initialize :set_default_source_sub_id
  after_commit :flush_cache

  delegate :source_id, :title, :citation, :formatted_citation, :location, :literature_type, :journal, :document, :author_name, to: :paper
  attr_accessor :calculation_list
  accepts_nested_attributes_for :performance_measures

  def self.find(input)
    input.to_i == 0 ? where(source_sub_id: input).first : super
  end

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

  def self.cached_calculations
    Rails.cache.fetch([name, 'calculations']){ pluck(:calculations).flatten.uniq.sort }
  end

  def cached_species_list
    Rails.cache.fetch([self, 'species-list']){ species_list }
  end

  def cached_focus_list
    Rails.cache.fetch([self, 'focus-list']){ focus_list }
  end

  scope :with_paper_and_author, -> { joins(paper: :author) }
  scope :for_species,     -> (species) { tagged_with(species, on: :species) }
  scope :for_any_species, -> (species) { tagged_with(species, on: :species, any: true) }
  scope :for_focus,       -> (focus)   { tagged_with(focus, on: :focus) }
  scope :for_any_focus,   -> (focus)   { tagged_with(focus, on: :focus, any: true) }
  scope :for_author,      -> (author)  { where authors: { id: author } }
  scope :for_journal,     -> (journal) { where papers: { journal: journal } }

  def to_param
    source_sub_id
  end

  def complete_source_id
    [source_id, source_sub_id].join '-'
  end

  def calculation_list
    calculations.join ', '
  end

  def calculation_list=(list)
    list ||= []
    self.calculations = list.is_a?(String) ? list.split(',').map(&:strip) : list
  end

  private

  def flush_cache
    Rails.cache.delete([self.class.name, 'years'])
    Rails.cache.delete([self.class.name, 'species'])
    Rails.cache.delete([self.class.name, 'focuses'])
    Rails.cache.delete([self.class.name, 'calculations'])
    Rails.cache.delete([self, 'species-list'])
    Rails.cache.delete([self, 'focus-list'])
  end

  def set_default_source_sub_id
    self.source_sub_id ||= Trial.where(paper_id: paper_id).maximum(:source_sub_id).try(:succ) || 'A'
  end
end
