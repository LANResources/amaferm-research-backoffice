class Author < ActiveRecord::Base
  has_many :papers, dependent: :destroy

  validates :last_name, presence: true,
                        uniqueness: { case_sensitive: false }

  after_commit :flush_cache

  def self.find_or_create_from(name)
    where('last_name ILIKE ?', name).first || create(last_name: name.try(:capitalize))
  end

  def self.cached_names
    Rails.cache.fetch([name, 'names']){ pluck(:last_name).uniq.sort }
  end

  def self.cached_all
    Rails.cache.fetch([name, 'all']){ order(:last_name).all }
  end

  private

  def flush_cache
    Rails.cache.delete([self.class.name, 'all'])
    Rails.cache.delete([self.class.name, 'names'])
  end
end
