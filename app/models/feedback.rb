class Feedback < ActiveRecord::Base
  default_scope :order => 'created_at desc'
  scope :related_feedbacks, lambda { |text| where("subject LIKE '%' :tag '%' or content LIKE '%' :tag '%'", {:tag => text}) }
  scope :latest_related_feedbacks, lambda { |text,limit| related_feedbacks(text).limit(limit) }
  scope :recent_feedbacks, lambda { |date| Feedback.where('created_at >= ?', date) }
  scope :latest_recent_feedbacks, lambda { |date,limit| recent_feedbacks(date).limit(limit) }

  TEN_MINUTES = 600

  belongs_to :feedback_type
  accepts_nested_attributes_for :feedback_type
  belongs_to :project
  belongs_to :user
  has_many :comments

  attr_accessible :project, :user, :feedback_type, :project_id, :user_id, :comments,
                  :subject, :content, :created_at, :updated_at, :client_visibility, :mooveit_visibility, :feedback_type_id

  validates :feedback_type, :user, :project, :subject, :content, :presence => true


  def self.reset_pk_sequence
    ActiveRecord::Base.connection.reset_pk_sequence!("Feedback")
  end

  #check if the feedback can be edited by the current user
  def editable?(current_user_id)
    # calculate how old is the feedback
    created_at = self.created_at.to_time
    diff_seconds = (Time.now - created_at).round

    (self.user.id == current_user_id) && (diff_seconds < TEN_MINUTES)
  end

  # remaining time for edit
  def remaining_time
    # calculate how old is the feedback
    created_at = self.created_at.to_time
    diff_seconds = (Time.now - created_at).round
    remaining = TEN_MINUTES - diff_seconds

    remaining.to_s
  end

  def last_modification
    comments = self.comments
    if comments.first
      comments.last.created_at
    else
      updated_at
    end
  end

  def self.project_feedbacks(project_id)
    Feedback.find_all_by_project_id(project_id).sort! { |b, a| a.last_modification <=> b.last_modification }
  end

  def self.date_filter_feedbacks(project_id,date)
    Feedback.where('project_id = ? AND created_at >= ?', project_id, date).sort! { |b, a| a.last_modification <=> b.last_modification }
  end

  def last_comment
    self.comments.last
  end

end
