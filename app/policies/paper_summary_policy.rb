class PaperSummaryPolicy < ApplicationPolicy

  def index?
    !user.guest?
  end

  def show?
    !user.guest?
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

  def manage?
    new?
  end

  def download?
    Pundit.policy(user, resource.trial).download?
  end

  def permitted_attributes
    [:title, :description, :species, :position, :featured, :document, :trial_id]
  end
end
