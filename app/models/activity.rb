# model used to populate the recent activity table in the administration summary tab
class Activity
  # this class is used as a wrapper for showing recent activity in the site and performing site queries

  attr_accessor :action, :author, :date_time, :image_path, :link, :content, :avatar

  def initialize(action, author, date_time, image_path, link = "", content = "", avatar = false)
    @action = action
    @author = author
    @date_time = date_time
    @image_path = image_path
    @link = link
    @content = content
    @avatar = avatar
  end

  # returns no more than limit activities, with date_time after date
  def self.recent_activity(date, limit)

    activities = Array.new
    activities_limit = limit

    feedbacks = Feedback.where('created_at >= ?', date).limit(limit)

    # we make an array with the latest mood updates for each project
    moods = Array.new
    Project.all.each do |project|
      mood = project.moods.first
      if mood and mood.created_at >= date
        moods.push mood
      end
    end

    comments = Comment.where('created_at >= ?', date).limit(limit)

    # defining weighs of feedbacks, mood updates and comments
    f_weigh = limit/2
    m_weigh = limit/4
    c_weigh = limit/4

    feedback = feedbacks.first
    mood = moods.first
    comment = comments.first
    while activities_limit > 0 && (feedback || mood || comment)

      # feedbacks are more relevant than moods
      # if moods and comments reach the limit (weigh or size) then we prefer to pick a feedback rather than a mood or comment
      if feedback && activities_limit > 0 && (f_weigh > 0 || (m_weigh <= 0 || !mood) || (c_weigh <= 0 || !comment))

        activities.push Activity.new("New feedback " + feedback.subject + " on " + feedback.project.name,
                                     feedback.user.full_name,
                                     feedback.created_at,
                                     feedback.feedback_type.image_url,
                                     '/my_projects/' + feedback.project.id.to_s,
                                     feedback.content )
        f_weigh = f_weigh - 1
        feedbacks.shift
        feedback = feedbacks.first
        activities_limit = activities_limit - 1
      end

      # moods are more relevant than comments but not more relevant than feedbacks
      # if comments reach the limit (weigh or size) then, if we do not have more feedbacks we pick a mood
      if mood && activities_limit > 0 && (m_weigh > 0 || (!feedback && (c_weigh <= 0 || !comment)))

        activities.push Activity.new("Mood update on project " + mood.project.name + "!",
                                     "",
                                     mood.created_at,
                                     'moods/normal/' + mood.get_mood_img,
                                     '/my_projects/' + mood.project.id.to_s )
        m_weigh = m_weigh - 1
        moods.shift
        mood = moods.first
        activities_limit = activities_limit - 1
      end

      # we pick a comment if we do not reach the limit (weigh or size) or if we do not have any feedbacks or mood updates
      if comment && activities_limit > 0 && (c_weigh > 0 || (!feedback && !mood))


        if comment.user.profile.show_gravatar
          picture = comment.user.profile.user.email.gsub('spam', 'mdeering')
        else
          if comment.user.profile.avatar.file?
            picture = comment.user.profile.avatar.url(:medium)
          else
            picture = "default_user_pic.png"
          end
        end

        activities.push Activity.new("New comment on feedback " + comment.feedback.subject,
                                     comment.user.full_name,
                                     comment.created_at,
                                     picture,
                                     '/my_projects/' + comment.feedback.project.id.to_s,
                                     comment.content,
                                     comment.user.profile.show_gravatar )
        c_weigh = c_weigh - 1
        comments.shift
        comment = comments.first
        activities_limit = activities_limit - 1
      end
    end
    activities.sort! { |a,b| a.date_time <=> b.date_time }.reverse
  end

  def self.activity_filter(filter_text)

    activities = Array.new

    # if there is no text we return
    unless filter_text.length > 0
      return activities
    end

    # we query for text partially containing filter_text
    feedbacks = Feedback.where(["subject LIKE '%' :tag '%' or content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    comments = Comment.where(["content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    projects = Project.where(["name LIKE '%' :tag '%' or description LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    users = User.where(["full_name LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)

    feedbacks.each do |feedback|
      activities.push Activity.new("Feedback: " + feedback.subject + " on " + feedback.project.name,
                                   feedback.user.full_name,
                                   feedback.created_at,
                                   feedback.feedback_type.image_url,
                                   '/my_projects/' + feedback.project.id.to_s,
                                   feedback.content )

    end

    comments.each do |comment|

      # identifying users image url
      if comment.user.profile.show_gravatar
        picture = comment.user.profile.user.email.gsub('spam', 'mdeering')
      else
        if comment.user.profile.avatar.file?
          picture = comment.user.profile.avatar.url(:medium)
        else
          picture = "default_user_pic.png"
        end
      end

      activities.push Activity.new("Comment on feedback " + comment.feedback.subject,
                                   comment.user.full_name,
                                   comment.created_at,
                                   picture,
                                   '/my_projects/' + comment.feedback.project.id.to_s,
                                   comment.content,
                                   comment.user.profile.show_gravatar )
    end

    projects.each do |project|
      mood = project.moods.first
      activities.push Activity.new("Project " + project.name + ", " + project.client.name,
                                   "",
                                   project.created_at,
                                   'moods/normal/' + mood.get_mood_img,
                                   '/my_projects/' + project.id.to_s,
                                   project.description )

    end

    users.each do |user|
      if user.profile.show_gravatar
        picture = user.profile.user.email.gsub('spam', 'mdeering')
      else
        if user.profile.avatar.file?
          picture = user.profile.avatar.url(:medium)
        else
          picture = "default_user_pic.png"
        end
      end

      if user.admin?
        user_role = "Administrator"
      elsif user.client?
        user_role = user.client.name
      else
        user_role = "Moove-IT Employee"
      end

      activities.push Activity.new("User " + user.full_name + ", " + user_role,
                                   "",
                                   user.created_at,
                                   picture,
                                   "",
                                   "",
                                   user.profile.show_gravatar )

    end

    activities
  end

end