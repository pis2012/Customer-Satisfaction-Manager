class Client < ActiveRecord::Base
  default_scope :order => 'name'
  scope :related_clients, lambda { |text| where(["name LIKE '%' :tag '%'", {:tag => text}]) }
  scope :latest_related_clients, lambda { |text,limit| related_clients(text).limit(limit) }

  has_many :projects
  has_many :users
  has_and_belongs_to_many :forms

  before_destroy :ensure_not_ref_by_any_project
  before_destroy :ensure_not_ref_by_any_user

  attr_accessible :projects, :users,
                  :id, :name

  validates :name, :presence => true
  validates :name, :uniqueness => true

  def ensure_not_ref_by_any_project
    unless projects.count.zero?
      errors.add(:base, "Projects present")
    end
  end

  def ensure_not_ref_by_any_user
    unless users.count.zero?
      errors.add(:base, "Users present")
    end
  end

  def mood_average
    average = 0
    projects.each do |p|
      average += p.mood.status
    end
    projects.count != 0 ? average/projects.count : 0
  end

  # This cannot be turned into scope. It's an opened issue in rails repository
  def self.recent_clients(date)
    Client.unscoped.where('created_at >= ?', date).order('created_at desc')
  end

  def self.latest_recent_clients(date,limit)
    Client.unscoped.where('created_at >= ?', date).order('created_at desc').limit(limit)
  end

end


