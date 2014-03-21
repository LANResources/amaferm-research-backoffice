class PerformanceMeasurePolicy < ApplicationPolicy
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
    user >= :manager
  end

  def update?
    edit?
  end

  def destroy?
    update?
  end

  def permitted_attributes
    [ :trial_id, :measure, :control, :amaferm ]
  end
end
