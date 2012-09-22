class Project < ActiveRecord::Base
  default_scope :order => 'name'

  belongs_to :client
  has_many :profiles
  has_many :milestones
  has_many :moods
  has_many :feedbacks

  attr_accessible :client, :milestones, :moods, :feedbacks,
                  :description, :end_date, :id, :name, :finalized

  #validates :name, :description, :end_date, :finalized,  :presence  => true

end
