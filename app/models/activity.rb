# model used to populate the recent activity table in the administration summary tab
class Activity

  attr_accessor :action, :author, :date_time, :image_path, :link, :content

  def initialize(action, author, date_time, image_path, link, content = "")
    @action = action
    @author = author
    @date_time = date_time
    @image_path = image_path
    @link = link
    @content = content
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

    while activities_limit > 0 && (moods.length > 0 || feedbacks.length > 0 || comments.length > 0)

      # feedbacks are more relevant than moods
      if feedbacks.length > 0 && activities_limit > 0
        feedback = feedbacks.first
        new_activity = Activity.new(action: "New Feedback: " + feedback.subject,
                                     author: feedback.user.full_name,
                                     date_time: feedback.created_at,
                                     image_path: feedback.feedback_type.image_url,
                                     link: '/projects/change_profile_project_path/' + feedback.project.id.to_s,
                                     content: feedback.content )
        activities.push new_activity
        feedbacks.pop
        activities_limit = activities_limit - 1
      end

      # moods are more relevant than comments
      if moods.length > 0 && activities_limit > 0
        mood = moods.first
        activities.push Activity.new(action: "Mood Update!",
                                     author: mood.project.client.name,
                                     date_time: mood.created_at,
                                     image_path: 'moods/normal/' + mood.get_mood_img,
                                     link: '/projects/change_profile_project_path/' + mood.project.id.to_s )
        moods.pop
        activities_limit = activities_limit - 1
      end

      if comments.length > 0 && activities_limit > 0
        comment = comments.first
        activities.push Activity.new(action: "New Comment",
                                     author: comment.user.full_name,
                                     date_time: comment.created_at,
                                     image_path: 'moods/normal/' + comment.get_mood_img,
                                     link: '/projects/change_profile_project_path/' + comment.feedback.project.id.to_s )
        comments.pop
        activities_limit = activities_limit - 1
      end
    end
    activities
  end
end