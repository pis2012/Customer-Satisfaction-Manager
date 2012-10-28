class Comment < ActiveRecord::Base

  belongs_to :feedback
  belongs_to  :user

  attr_accessible :feedback, :user,:feedback_id,  :user_id,
                  :content, :created_at, :updated_at

  validates :feedback, :user,:content, :presence  => true
  validates_length_of :content, :minimum => 40
end
