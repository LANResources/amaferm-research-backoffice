class Author < ActiveRecord::Base
  has_many :papers, dependent: :destroy

  validates :last_name, presence: true,
                        uniqueness: { case_sensitive: false }
end
