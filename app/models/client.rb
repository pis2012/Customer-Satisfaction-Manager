class Client < ActiveRecord::Base
  default_scope :order => 'name'

  has_many :projects
  has_many :users

  before_destroy :ensure_not_referenced_by_any_project
  before_destroy :ensure_not_referenced_by_any_user

  attr_accessible :projects, :users,
                  :name, :created_at

  validates :name, :presence => true
  validates :name, :uniqueness => true

  def ensure_not_referenced_by_any_project
    if projects.count.zero?
      return true
    else
      errors[:base] << "Projects present"
      return false
    end
  end

  def ensure_not_referenced_by_any_user
    if users.count.zero?
      return true
    else
      errors[:base] << "Users present"
      return false
    end
  end


end


