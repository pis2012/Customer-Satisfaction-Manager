class Role < ActiveRecord::Base

  ADMIN_ROLE =   'Admin'
  MOOVEIT_ROLE = 'Mooveit'
  CLIENT_ROLE =  'Client'

  has_many :users

  attr_accessible :id, :name

  validates :name, :presence  => true
  validates :name, :uniqueness => true

end
