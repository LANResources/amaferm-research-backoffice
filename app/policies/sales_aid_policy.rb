class SalesAidPolicy < ApplicationPolicy
  class Scope < Scope
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

  def manage?
    new?
  end

  def download?
    level = resource.access_level.to_sym
    if user >= :biozyme
      true
    elsif user >= :public_sales
      level.in? [:guest, :public_sales]
    else
      level == :guest
    end
  end

  def permitted_attributes
    [:title, :user_id, :category, :access_level, :document, :position, :video_id, :link]
  end
end
