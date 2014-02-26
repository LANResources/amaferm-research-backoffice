class PaperPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user >= :biozyme
        scope.all
      else
        scope.where(level: Paper.levels[:basic])
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
      :source_id, :citation, :level, :author_id, :dose, :year, :literature_type, 
      :journal, :summary, :species_list, :focus_list, :forage, :concentrate, 
      :document, :author_name
    ]
  end
end
