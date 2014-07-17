class AccessRequest < ActiveRecord::Base
  OCCUPATIONS = ['Nutritionist', 'Sales Rep', 'Tech Support', 'Research and Development']
  SPECIES = ['Beef Cattle', 'Dairy Cattle', 'Goat', 'Horse', 'Sheep', 'Pig']

  validates_presence_of :first_name, :last_name, :title, :phone, :occupation, :species
  validates :email, presence: true, format: { with: User::VALID_EMAIL_REGEX }

  def full_name
    "#{first_name} #{last_name}"
  end
end
