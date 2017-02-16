class SupplementalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user >= :admin
        scope
      else
        scope.where level: SupplementalPolicy.new(user, nil).accessible_levels.values
      end
    end
  end

  def index?
    true
  end

  def show?
    accessible_levels.has_key? resource.level
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

  def manage?
    create? || update?
  end

  def accessible_levels
    Supplemental.levels.select do |level,_|
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
      :paper_id, :source_sub_id, :title, :level, :year, :author_id,
      :author_name, :citation, :summary, :literature_type, :document
    ]
  end
end
