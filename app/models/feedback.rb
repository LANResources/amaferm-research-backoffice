class Feedback
  include ActiveModel::Model

  attr_accessor :user, :phone, :city_state, :name, :email, :comments

  def user_name
    user.guest? ? "#{name} (Guest)" : user.full_name
  end

  def user_email
    user.guest? ? email : user.email
  end
end
