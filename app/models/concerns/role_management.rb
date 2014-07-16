module RoleManagement
  extend ActiveSupport::Concern

  included do
    STATUSES ||= %w[registered invited]
    ROLES ||= [:guest, :public_sales, :basic, :basic_manager, :biozyme, :manager, :admin]

    if respond_to? :enum
      enum role: { basic: 0, biozyme: 1, manager: 2, admin: 3, basic_manager: 4, public_sales: 5 }
    end

    validates :role, presence: true
  end

  def status
    password_digest.nil? ? 'invited' : 'registered'
  end

  def invited?
    status == 'invited'
  end

  def registered?
    status == 'registered'
  end

  def guest?
    role == 'guest'
  end

  def assignable_roles
    case self.role.to_sym
    when :admin
      ROLES[1..6]
    when :manager
      ROLES[1..5]
    when :biozyme
      ROLES[1..4]
    when :basic_manager
      ROLES[1..2]
    else
      []
    end
  end

  def <(other)
    return false if other == User
    return false unless comparable? other
    return true if self.role.nil?
    ROLES.index(self.role.to_sym) < ROLES.index((other.try(:role) || other).try(:to_sym)).to_i
  end

  def <=(other)
    return false if other == User
    return false unless comparable? other
    return true if self.role.nil?
    ROLES.index(self.role.to_sym) <= ROLES.index((other.try(:role) || other).try(:to_sym)).to_i
  end

  def >(other)
    return true if other == User
    return false unless comparable? other
    return false if self.role.nil?
    ROLES.index(self.role.to_sym) > ROLES.index((other.try(:role) || other).try(:to_sym)).to_i
  end

  def >=(other)
    return true if other == User
    return false unless comparable? other
    return false if self.role.nil?
    ROLES.index(self.role.to_sym) >= ROLES.index((other.try(:role) || other).try(:to_sym)).to_i
  end

  private
    def comparable?(obj)
      obj.class.ancestors.include?(RoleManagement) || obj.try(:to_sym).in?(ROLES)
    end
end
