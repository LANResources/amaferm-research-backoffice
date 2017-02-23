class RoleImpersonationPolicy < Struct.new(:user, :role_impersonation)
  def new?
    user.admin? || user.matches_any?(['Elishia Carrillo', 'Ming He'])
  end

  def create?
    new?
  end

  def destroy?
    user.impersonating?
  end
end
