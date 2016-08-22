class SalesAidPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user >= :admin
        scope
      else
        scope.where access_level: SalesAidPolicy.new(user, nil).accessible_levels.values
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
    accessible_levels.has_key? resource.access_level
  end

  def accessible_levels
    SalesAid.access_levels.select do |level,_|
      if user >= :admin
        true
      elsif user >= :biozyme
        level != '_private'
      elsif user >= :public_sales
        level.in? %w[guest public_sales]
      else
        level == 'guest'
      end
    end
  end

  def permitted_attributes
    [:title, :user_id, :category, :access_level, :document, :position, :video_id, :link]
  end
end
