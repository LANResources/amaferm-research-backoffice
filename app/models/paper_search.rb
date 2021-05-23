class PaperSearch
  include ActiveModel::Model

  ARRAY_ATTRIBUTES = [:years, :authors, :locations, :species, :focuses, :literature_types, :products, :levels]
  attr_accessor :page, :content, *ARRAY_ATTRIBUTES
  attr_reader :results

  ARRAY_ATTRIBUTES.each do |attribute|
    define_method("#{attribute}=") do |val|
      instance_variable_set("@#{attribute}", Array(val))
    end
  end

  def self.lookup(search)
    return nil if search.blank?

    if search.to_s =~ /(\d+)-([a-zA-Z]+)/
      Trial.joins(:paper).merge(Paper.where(source_id: $1.to_i)).where(source_sub_id: $2).take
    elsif search.to_s =~ /\d+/
      Paper.find_by(source_id: search.to_i)
    else
      nil
    end
  end

  def initialize(params = {})
    super(params)
    @years ||= []
    @authors ||= []
    @locations ||= []
    @species ||= []
    @focuses ||= []
    @literature_types ||= []
    @products ||= []
    @levels ||= []
    @page = @page ? @page.to_i : 1
  end

  def search
    @results = Trial.joins(paper: :author)

    match_years
    match_authors
    match_locations
    match_species
    match_focuses
    match_literature_types
    match_products
    match_levels
    match_content
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

    def match_locations
       @results = @results.where(papers: { location: locations }) if locations.any?
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

    def match_products
      @results = @results.where(papers: {product: products}) if products.any?
      self
    end

    def match_levels
      @results = @results.where(level: levels.map{|level| Trial.levels[level] }) if levels.any?
      self
    end

    def match_content
      if @content.present?
        search_string = "%#{@content.squeeze(' ').gsub('%', '\%').gsub(' ', '%')}%"
        @results = @results.where('papers.title ILIKE ? OR trials.summary ILIKE ?', search_string, search_string)
      end
      self
    end

    def order_results
      @results = @results.select('trials.*, papers.*').order('papers.source_id ASC, trials.source_sub_id ASC').uniq
      self
    end
end
