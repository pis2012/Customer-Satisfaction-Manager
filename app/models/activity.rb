# model used to populate the recent activity table in the administration summary tab
class Activity
  # this class is used as a wrapper for showing recent activity in the site and performing site queries

  # returns no more than limit activities, with date_time after date
  def self.recent_activity

    date = 1.day.ago
    limit = 20

    feedbacks = Feedback.where('created_at >= ?', date)
    # we take the latest mood updates for each project
    moods = Project.joins(:mood).where('moods.created_at >= ?', date).collect { |p| p.mood }

    comments = Comment.where('created_at >= ?', date).limit(limit)
    projects = Project.where('created_at >= ?', date).limit(limit)
    users = User.where('created_at >= ?', date).limit(limit)
    clients = Client.where('created_at >= ?', date).limit(limit)

    recent_activities = feedbacks + moods + comments + projects + users + clients

    recent_activities = recent_activities.sort { |x,y| y.created_at <=> x.created_at }

    recent_activities.first(limit)
  end

  def self.activity_filter(filter_text)

    # if there is no text we return
    return [] if filter_text.blank?

    # we query for text partially containing filter_text
    feedbacks = Feedback.where(["subject LIKE '%' :tag '%' or content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    comments = Comment.where(["content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    projects = Project.where(["name LIKE '%' :tag '%' or description LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    users = User.where(["full_name LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    clients = Client.where(["name LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)

    feedbacks + comments + projects + users + clients
  end

end