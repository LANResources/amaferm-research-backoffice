class PaperSearch
  include ActiveModel::Model 

  ARRAY_ATTRIBUTES = [:years, :authors, :species, :focuses, :literature_types]
  attr_accessor *ARRAY_ATTRIBUTES
  attr_reader :results

  ARRAY_ATTRIBUTES.each do |attribute|
    define_method("#{attribute}=") do |val|
      instance_variable_set("@#{attribute}", Array(val))
    end
  end

  def initialize(params = {})
    super(params)
    @years ||= []
    @authors ||= []
    @species ||= []
    @focuses ||= []
    @literature_types ||= []
  end

  def search
    @results = Trial.joins(paper: :author)

    match_years
    match_authors
    match_species
    match_focuses
    match_literature_types
    order_results
  end

  private

    def match_years
      @results = @results.where(year: years) if years.any?
      self
    end

    def match_authors
       @results = @results.where(authors: { last_name: authors }) if authors.any?
       self
    end

    def match_species
      @results = @results.for_any_species(species) if species.any?
      self
    end

    def match_focuses
      @results = @results.for_any_focus(focuses) if focuses.any?
      self
    end

    def match_literature_types
      @results = @results.where(papers: {literature_type: literature_types}) if literature_types.any?
      self
    end

    def order_results
      @results.order('year DESC', 'title ASC')
      self
    end
end