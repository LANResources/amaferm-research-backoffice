module RoleManagement
  extend ActiveSupport::Concern

  included do
    STATUSES = %w[registered invited]
    ROLES = [:basic, :biozyme, :manager, :admin]

    enum role: ROLES

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

  def assignable_roles
    case self.role.to_sym
    when :admin
      ROLES
    when :manager
      ROLES[0..2]
    when :biozyme
      ROLES[0..1]
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
      obj.kind_of?(self.class) || obj.try(:to_sym).in?(ROLES)
    end
end
