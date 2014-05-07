class InvitePolicy < ApplicationPolicy
  def create?
    user >= :basic_manager
  end

  def edit?
    update?
  end

  def update?
    user == resource
  end
end
