class FeedbackType < ActiveRecord::Base

  attr_accessible :id, :name

  validates :name, :presence  => true
  validates :name, :uniqueness => true

end
