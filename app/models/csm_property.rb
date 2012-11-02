class CsmProperty < ActiveRecord::Base
  attr_accessible :name, :value

  validates_uniqueness_of :name
  validates_presence_of :value

end
