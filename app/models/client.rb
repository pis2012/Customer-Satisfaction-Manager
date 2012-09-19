class Client < ActiveRecord::Base
  #default_scope where("visible = ?", true)
  has_many :projects
  has_many :users

  attr_accessible :id, :name
end


