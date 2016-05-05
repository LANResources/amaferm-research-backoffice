class SupplementalPolicy < ApplicationPolicy
  class Scope < Scope
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
  
  def manage?
    create? || update?
  end

  def permitted_attributes
    [
      :paper_id, :source_sub_id, :title, :level, :year, :author_id, 
      :author_name, :citation, :summary, :literature_type, :document 
    ]
  end
end
