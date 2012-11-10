# model used to populate the recent activity table in the administration summary tab
class Activity
  # this class is used as a wrapper for showing recent activity in the site and performing site queries

  # returns no more than limit activities, with date_time after date
  def self.recent_activity

    date = 1.day.ago
    limit = 20

    feedbacks = Feedback.latest_recent_feedbacks(date,limit)
    # we take the latest mood updates for each project
    moods = Project.unscoped.joins(:mood).where('moods.created_at >= ?', date).order('moods.created_at desc').limit(limit).collect { |p| p.mood }

    comments = Comment.latest_recent_comments(date,limit)
    projects = Project.latest_recent_projects(date,limit)
    users = User.latest_recent_users(date,limit)
    clients = Client.latest_recent_clients(date,limit)

    recent_activities = feedbacks + moods + comments + projects + users + clients

    recent_activities = recent_activities.sort { |x,y| y.created_at <=> x.created_at }

    recent_activities.first(limit)
  end

  def self.activity_filter(filter_text)

    # if there is no text we return
    return [] if filter_text.blank?

    # we query for text partially containing filter_text
    feedbacks = Feedback.latest_related_feedbacks(filter_text,10)
    comments = Comment.latest_related_comments(filter_text,10)
    projects = Project.latest_related_projects(filter_text,10)
    users = User.latest_related_users(filter_text,10)
    clients = Client.latest_related_clients(filter_text,10)

    feedbacks + comments + projects + users + clients
  end

end