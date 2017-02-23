class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.guest?
        scope.none
      elsif user == :admin
        scope
      else
        scope.where role: user.assignable_roles.map{|r| User.roles[r] }
      end
    end
  end

  def index?
    user >= :basic_manager
  end

  def show?
    user >= :admin || user == resource || (!user.guest? && scope.where(id: resource.id).exists?)
  end

  def new?
    user >= :basic_manager
  end

  def create?
    new? && user >= resource
  end

  def edit?
    update?
  end

  def update?
    user == resource || (create? && !resource.admin? && !(user.manager? && resource.manager?))
  end

  def destroy?
    create? && !resource.admin? && user != resource && !(user.manager? && resource.manager?)
  end

  def export?
    user >= :admin
  end

  def permitted_attributes
    attributes = [:first_name, :last_name, :email, :password, :password_confirmation, :avatar]
    attributes += [:role] if user >= :biozyme && user >= resource
    attributes
  end
end
