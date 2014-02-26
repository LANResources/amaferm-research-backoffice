module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = self
      filtering_params.each do |key, value|
        results = results.public_send("for_#{key}", value) if value.present?
      end
      results
    end
  end
end