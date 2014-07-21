class TrialPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user >= :biozyme
        scope #.all
      elsif user >= :basic
        scope.where level: [Trial.levels[:web], Trial.levels[:shared]]
      else
        scope.where level: Trial.levels[:web]
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
    level = resource.level.to_sym
    if user >= :biozyme
      true
    elsif user >= :basic
      level.in? [:web, :shared]
    else
      level == :web
    end
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
    user >= :manager
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
