class Project < ActiveRecord::Base
  belongs_to :client
  has_many :users

  attr_accessible :client_id, :description, :end_date, :id, :name, :status
end
