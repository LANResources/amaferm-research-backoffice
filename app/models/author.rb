class Author < ActiveRecord::Base
  has_many :papers, dependent: :destroy

  validates :last_name, presence: true,
                        uniqueness: { case_sensitive: false }

  def self.find_or_create_from(name)
    where('last_name ILIKE ?', name).first || create(last_name: name.try(:capitalize))
  end
end
