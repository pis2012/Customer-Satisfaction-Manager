class Comment < ActiveRecord::Base
  default_scope :order => 'created_at asc'
  scope :related_comments, lambda { |text| where("content LIKE '%' :tag '%'", {:tag => text}) }
  scope :latest_related_comments, lambda { |text,limit| related_comments(text).limit(limit) }

  belongs_to :feedback
  belongs_to  :user

  attr_accessible :feedback, :user,:feedback_id,  :user_id,
                  :content, :created_at, :updated_at

  validates :feedback, :user,:content, :presence  => true

  # This cannot be turned into scope. It's an opened issue in rails repository
  def self.recent_comments(date)
    Comment.unscoped.where('created_at >= ?', date).order('created_at desc')
  end

  def self.latest_recent_comments(date,limit)
    Comment.unscoped.where('created_at >= ?', date).order('created_at desc').limit(limit)
  end

end
