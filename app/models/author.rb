class Author < ActiveRecord::Base
  has_many :papers, dependent: :destroy
  has_many :supplementals, dependent: :destroy

  validates :last_name, presence: true,
                        uniqueness: { case_sensitive: false }

  scope :having_papers, ->(user = User.new) { joins(papers: :trials).where(trials: {level: TrialPolicy.new(user, nil).accessible_levels.values}) }

  after_commit :flush_cache

  def self.find_or_create_from(name)
    where('last_name ILIKE ?', name).first || create(last_name: name.sub(/^(\w)/){|s| s.capitalize})
  end

  def self.cached_names
    Rails.cache.fetch([name, 'names']){ pluck(:last_name).uniq.sort }
  end

  def self.cached_names_having_papers(user)
    user ||= User.new
    Rails.cache.fetch([name, 'names-having-papers', user.current_role]){ having_papers(user).pluck(:last_name).uniq.sort }
  end

  def self.cached_all
    Rails.cache.fetch([name, 'all']){ order(:last_name).all }
  end

  def self.cached_having_papers(user)
    user ||= User.new
    Rails.cache.fetch([name, 'having-papers', user.current_role]){ having_papers(user).uniq.order(:last_name).all }
  end

  private

  def flush_cache
    Rails.cache.delete([self.class.name, 'all'])
    Rails.cache.delete([self.class.name, 'names'])
    User.roles.values.each do |role|
      Rails.cache.delete([self.class.name, 'having-papers', role])
      Rails.cache.delete([self.class.name, 'names-having-papers', role])
    end
  end
end
