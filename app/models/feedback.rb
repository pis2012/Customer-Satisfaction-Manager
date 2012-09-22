class Feedback < ActiveRecord::Base

  belongs_to :project
  belongs_to :user           # autor del feedback
  belongs_to :feedback_type

  # feeling : -1 .. 1
  attr_accessible :subject, :content, :feeling, :visibility

  #:presence => true tells the validator to check that each of the named fields is
  #present and its contents are not empty

  validates :subject, :client_visibility, :mooveit_visibility, :content, :feeling, :presence => true
  validates :feeling, :numericality => {:greater_than_or_equal_to => -1, :less_than_or_equal_to => 1}

end
