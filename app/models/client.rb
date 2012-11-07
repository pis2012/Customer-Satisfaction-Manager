class Client < ActiveRecord::Base
  default_scope :order => 'name'

  has_many :projects
  has_many :users

  before_destroy :ensure_not_ref_by_any_project
  before_destroy :ensure_not_ref_by_any_user

  attr_accessible :projects, :users,
                  :id, :name

  validates :name, :presence => true
  validates :name, :uniqueness => true

  def ensure_not_ref_by_any_project
    if projects.count.zero?
      true
    else
      errors[:base] << "Projects present"
      false
    end
  end

  def ensure_not_ref_by_any_user
    if users.count.zero?
      true
    else
      errors[:base] << "Users present"
      false
    end
  end

  def mood_average
    average = 0
    projects.each do |p|
      average += p.mood.status
    end
    projects.count != 0 ? average/projects.count : 0
  end

  def self.text_filter_clients(filter_text)
    Client.where("name LIKE '%' :tag '%'", {:tag => filter_text})
  end


end


