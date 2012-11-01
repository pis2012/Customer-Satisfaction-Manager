# model used to populate the recent activity table in the administration summary tab
class Activity

  attr_accessor :action, :author, :date_time, :image_path, :link, :content, :avatar

  def initialize(action, author, date_time, image_path, link, content = "", avatar = false)
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

    # we make an array with the latest mood updates for each project
    moods = Array.new
    Project.all.each do |project|
      mood = project.moods.first
      if mood.created_at >= date
        moods.push mood
      end
    end

    feedbacks = Feedback.where('created_at >= ?', date)
    comments = Comment.where('created_at >= ?', date)

    m_weigh = limit/4
    f_weigh = limit/2
    c_weigh = limit/4

    while activities_limit > 0 && (moods.size > 0 || feedbacks.size > 0 || comments.size > 0)

      # feedbacks are more relevant than moods
      if feedbacks.size > 0 && activities_limit > 0 && (f_weigh > 0 || (m_weigh <= 0 && c_weigh <= 0))
        feedback = feedbacks.first
        activities.push Activity.new("New feedback: " + feedback.subject + " on " + feedback.project.name,
                                     feedback.user.full_name,
                                     feedback.created_at,
                                     feedback.feedback_type.image_url,
                                     '/my_projects/' + feedback.project.id.to_s,
                                     feedback.content )
        f_weigh = f_weigh - 1
        feedbacks.shift
        activities_limit = activities_limit - 1
      end

      # moods are more relevant than comments
      if moods.size > 0 && activities_limit > 0 && (m_weigh > 0 || (f_weigh <= 0 && c_weigh <= 0))
        mood = moods.first
        activities.push Activity.new("Mood update on project " + mood.project.name + "!",
                                     mood.project.client.name,
                                     mood.created_at,
                                     'moods/normal/' + mood.get_mood_img,
                                     '/my_projects/' + mood.project.id.to_s )
        m_weigh = m_weigh - 1
        moods.shift
        activities_limit = activities_limit - 1
      end

      if comments.size > 0 && activities_limit > 0 && (c_weigh > 0 || (f_weigh <= 0 && m_weigh <= 0))
        comment = comments.first

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
        activities_limit = activities_limit - 1
      end
    end
    activities.sort! { |a,b| a.date_time <=> b.date_time }.reverse
  end

  def self.activity_filter(filter_text)

    activities = Array.new

    unless filter_text.length > 0
      return activities
    end

    feedbacks = Feedback.where(["subject LIKE '%' :tag '%' or content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)
    comments = Comment.where(["content LIKE '%' :tag '%'", {:tag => filter_text}]).limit(10)

    feedbacks.each do |feedback|
      activities.push Activity.new("New feedback: " + feedback.subject + " on " + feedback.project.name,
                                   feedback.user.full_name,
                                   feedback.created_at,
                                   feedback.feedback_type.image_url,
                                   '/my_projects/' + feedback.project.id.to_s,
                                   feedback.content )

    end

    comments.each do |comment|

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
    end

    activities
  end

end