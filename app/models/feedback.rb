class Feedback < ActiveRecord::Base
  belongs_to :feedback_type
  accepts_nested_attributes_for :feedback_type
  belongs_to :project
  belongs_to :user
  has_many :comments


  attr_accessible :project, :user, :feedback_type,:project_id,:user_id,
                  :subject, :content ,:created_at, :updated_at, :client_visibility, :mooveit_visibility  ,:feedback_type_id

  validates :feedback_type, :user, :project, :subject, :content, :presence  => true
end
