class TrialPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user >= :admin
        scope
      else
        scope.where level: TrialPolicy.new(user, nil).accessible_levels.values
      end
    end
  end

  def index?
    true
  end

  def search?
    true
  end

  def show?
    accessible_levels.has_key? resource.level
  end

  def download?
    show?
  end

  def export?
    user >= :manager
  end

  def new?
    user >= :manager
  end

  def create?
    new?
  end

  def edit?
    show? && user >= :manager
  end

  def update?
    edit?
  end

  def destroy?
    update?
  end

  def show_level?
    user >= :biozyme
  end

  def search_by_level?
    user >= :manager
  end

  def accessible_levels
    Trial.levels.select do |level,_|
      if user >= :admin
        true
      elsif user >= :biozyme
        level != '_private'
      elsif user >= :basic
        level.in? %w[web shared]
      else
        level == 'web'
      end
    end
  end

  def permitted_attributes
    [
      :source_sub_id, :level, :year, :summary, :dose, :species_list,
      :focus_list, :forage, :concentrate, :calculations, :calculation_list,
      performance_measures_attributes: permitted_performance_measure_attributes
    ]
  end

  private

  def permitted_performance_measure_attributes
    [
      :id, :measure, :control, :amaferm
    ]
  end
end
