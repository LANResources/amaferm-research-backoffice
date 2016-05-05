class PaperPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def search?
    true
  end
  
  def show?
    resource.trials.all.map{|t| TrialPolicy.new(user, t).show? || nil }.compact.any?
  end

  def download?
    show?
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
    [
      :source_id, :citation, :title, :location, :author_id, 
      :author_name, :journal, :literature_type, :document,
      trials_attributes: permitted_trial_attributes
    ]
  end

  private

  def permitted_trial_attributes
    [
      :id, :source_sub_id, :level, :year, :summary, :dose, :species_list, 
      :focus_list, :forage, :concentrate, :calculations, :calculation_list
    ]
  end
end
