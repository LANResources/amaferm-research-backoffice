class Country < ActiveRecord::Base
  self.primary_key = 'country_code'

  REGIONS = ['North America', 'South America', 'Europe', 'Asia', 'Africa', 'Oceania', 'Antarctica']

  validates_presence_of :country_code, :name

  scope :us_and_canada, -> { where(country_code: %w[US CA]) }
  scope :us_and_canada_first, -> { order("CASE WHEN country_code = 'US' THEN 0 WHEN country_code = 'CA' THEN 1 ELSE 2 END ASC, name ASC") }

  def self.grouped_options
    [
      ['Common', us_and_canada.to_a.map{|c| [c.name, c.country_code, {data: {region: c.region}}]}],
      ['------', where.not(country_code: %w[US CA]).order(name: :asc).map{|c| [c.name, c.country_code, {data: {region: c.region}}]}]
    ]
  end
end
