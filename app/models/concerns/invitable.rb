module Invitable
  extend ActiveSupport::Concern
  include Verifiable

  included do
    attr_accessor :signing_up
  end

  module ClassMethods
    def find_by_invite_token!(token)
      user_id, timestamp = self.verifier_for('invite').verify token

      self.find user_id
    end
  end

  def invite_token
    verifier = self.class.verifier_for 'invite'
    verifier.generate [id, updated_at]
  end

  def register(user_params)
    self.signing_up = true

    update user_params
  end
end