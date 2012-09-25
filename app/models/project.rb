class Project < ActiveRecord::Base
  default_scope :order => 'name'

  belongs_to :client
  has_many :profiles
  has_many :milestones
  has_many :moods
  has_many :feedbacks

  attr_accessible :client, :milestones, :moods, :feedbacks,
                  :description, :end_date, :name, :finalized

  validates :name, :description, :end_date, :presence  => true
  validates_inclusion_of :finalized, :in => [true, false]

  #validates :finalized, :inclusion => {:in => [true, false]}

end
