module PasswordResets
  extend ActiveSupport::Concern
  include Verifiable
  
  included do
    attr_accessor :resetting_password

    validates :password, presence: { on: :update }, if: :resetting_password
  end

  module ClassMethods
    def find_by_password_reset_token!(token)
      user_id, timestamp = self.verifier_for('password-reset').verify token

      if timestamp < 1.day.ago
        :expired
      else
        self.find user_id
      end
    end
  end

  def password_reset_token
    verifier = self.class.verifier_for 'password-reset'
    verifier.generate [id, Time.now]
  end

  def reset_password(user_params)
    self.resetting_password = true
 
    update_attributes user_params
  end
end