# model used to populate the recent activity table in the administration summary tab
class Activity
  # this class is used as a wrapper for showing recent activity in the site and performing site queries

  # returns no more than limit activities, with date_time after date
  def self.recent_activity(date, limit)

    feedbacks = Feedback.where('created_at >= ?', date)
    # we make an array with the latest mood updates for each project
    moods = Array.new
    Project.all.each do |project|
      mood = project.mood
      if mood.created_at >= date
        moods.push mood
      end
    end

    comments = Comment.where('created_at >= ?', date)
    projects = Project.where('created_at >= ?', date)
    users = User.where('created_at >= ?', date)
    clients = Client.where('created_at >= ?', date)

    recent_activities = feedbacks + moods + comments + projects + users + clients

    recent_activities = recent_activities.sort { |x,y| y.created_at <=> x.created_at }

    recent_activities.first(limit)
  end

  def self.activity_filter(filter_text)

    # if there is no text we return
    unless filter_text.length > 0
      return Array.new
    end

    # we query for text partially containing filter_text
    feedbacks = Feedback.where(["subject LIKE '%' :tag '%' or content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    comments = Comment.where(["content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    projects = Project.where(["name LIKE '%' :tag '%' or description LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    users = User.where(["full_name LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    clients = Client.where(["name LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)

    feedbacks + comments + projects + users + clients
  end

end