class Feedback < ActiveRecord::Base
  default_scope :order => 'created_at desc'

  TEN_MINUTES = 600

  belongs_to :feedback_type
  accepts_nested_attributes_for :feedback_type
  belongs_to :project
  belongs_to :user
  has_many :comments

  attr_accessible :project, :user, :feedback_type,:project_id,:user_id,
                  :subject, :content ,:created_at, :updated_at, :client_visibility, :mooveit_visibility  ,:feedback_type_id

  validates :feedback_type, :user, :project, :subject, :content, :presence  => true


  def self.reset_pk_sequence
        ActiveRecord::Base.connection.reset_pk_sequence!("Feedback")
  end

  #check if the feedback can be edited by the current user
  def editable? current_user_id
    # calculte how old is the feedback
    created_at   = self.created_at.to_time
    diff_seconds = (Time.now - created_at).round

    editable = (self.user.id == current_user_id) && (diff_seconds < TEN_MINUTES)

    return editable
  end

  # remaining time for edit
  def remaining_time
    # calculte how old is the feedback
    created_at   = self.created_at.to_time
    diff_seconds = (Time.now - created_at).round
    remaining    = TEN_MINUTES - diff_seconds

    return remaining.to_s
  end

end
