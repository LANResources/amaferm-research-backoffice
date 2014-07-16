class UserPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user.guest?
        scope.none
      else
        scope
      end
    end
  end

  def index?
    !user.guest?
  end

  def show?
    !user.guest?
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
