class Project < ActiveRecord::Base
  belongs_to :client
  has_many :users
  has_many :milestones
  has_many :moods
  has_many :feedbacks

  attr_accessible :client_id, :description, :end_date, :id, :name, :status
end
