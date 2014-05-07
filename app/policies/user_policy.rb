class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
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

  def permitted_attributes
    attributes = [:first_name, :last_name, :email, :password, :password_confirmation, :avatar]
    attributes += [:role] if user >= :biozyme && user >= resource
    attributes
  end
end
