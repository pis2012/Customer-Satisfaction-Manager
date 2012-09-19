class Role < ActiveRecord::Base

  has_many :users

  attr_accessible :id, :name
end
