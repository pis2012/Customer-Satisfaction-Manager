class Comment < ActiveRecord::Base
  default_scope :order => 'created_at asc'

  belongs_to :feedback
  belongs_to  :user

  attr_accessible :feedback, :user,:feedback_id,  :user_id,
                  :content, :created_at, :updated_at

  validates :feedback, :user,:content, :presence  => true

end
