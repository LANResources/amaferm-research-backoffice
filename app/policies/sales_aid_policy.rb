class SalesAidPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user >= :biozyme
        scope #.all
      elsif user >= :public_sales
        scope.where(access_level: [SalesAid.access_levels[:guest], SalesAid.access_levels[:public_sales]])
      else
        scope.where(access_level: SalesAid.access_levels[:guest])
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user >= :manager
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  def permitted_attributes
    [:title, :user_id, :category, :access_level, :document]
  end
end
