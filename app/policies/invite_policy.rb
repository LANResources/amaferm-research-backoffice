class InvitePolicy < ApplicationPolicy
  def create?
    user >= :biozyme
  end

  def edit?
    update?
  end

  def update?
    user == resource
  end
end
