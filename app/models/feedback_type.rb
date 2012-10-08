class FeedbackType < ActiveRecord::Base

  attr_accessible :id, :name, :image_url

  validates :name, :image_url, :presence  => true
  validates :name, :uniqueness => true

end
