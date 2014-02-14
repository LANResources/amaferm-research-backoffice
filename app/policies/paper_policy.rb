class PaperPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user >= :biozyme
        scope.all
      else
        scope.where(level: :basic)
      end
    end
  end

  def index?
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
      :source_id, :citation, :level, :author_id, :dose, :year, :literature_type, 
      :journal, :species, :forage, :concentrate, :document
    ]
  end
end
