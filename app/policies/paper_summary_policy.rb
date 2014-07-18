class PaperSummaryPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user >= :admin
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

  def download?
    Pundit.policy(user, resource.trial).download?
  end

  def permitted_attributes
    [:title, :description, :species, :position, :featured, :document, :trial_id]
  end
end
