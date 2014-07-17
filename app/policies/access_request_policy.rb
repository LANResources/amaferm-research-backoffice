class AccessRequestPolicy < ApplicationPolicy

  def new?
    true
  end

  def create?
    true
  end

  def permitted_attributes
    [:first_name, :last_name, :title, :company, :email, :phone, :occupation, {species: []}]
  end
end
