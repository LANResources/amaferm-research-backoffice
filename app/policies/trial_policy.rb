class TrialPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user >= :biozyme
        scope.all
      else
        scope.where(level: Trial.levels[:basic])
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
    true
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
      :source_sub_id, :level, :year, :summary, :dose, :species, 
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
