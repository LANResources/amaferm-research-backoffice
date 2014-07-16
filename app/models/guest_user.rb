class GuestUser
  include ActiveModel::Model
  include RoleManagement

  attr_reader :first_name, :last_name, :email
  
  def role
    'guest'
  end

  def full_name
    'Guest'
  end
end