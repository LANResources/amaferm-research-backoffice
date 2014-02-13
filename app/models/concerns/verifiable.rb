module Verifiable
  extend ActiveSupport::Concern

  module ClassMethods
    def verifier_for(purpose)
      @verifiers ||= {}
      @verifiers.fetch(purpose) do |p|
        @verifiers[p] = Rails.application.message_verifier "#{self.name}-#{p.to_s}"
      end
    end
  end
end