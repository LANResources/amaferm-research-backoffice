class Feedback
  include ActiveModel::Model

  attr_accessor :user, :phone, :city_state, :comments
end
