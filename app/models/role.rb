class Role < ActiveRecord::Base

  has_many :users

  attr_accessible :id, :name

  validates :name, :presence  => true
  validates :name, :uniqueness => true

end
