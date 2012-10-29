# model used to populate the recent activity table in the administration summary tab
class Activity

  attr_accessor :action, :author, :date_time, :image_path, :link

  def initialize(action, author, date_time, image_path)
    @action = action
    @author = author
    @date_time = date_time
    @image_path = image_path
  end

  # returns no more than limit activities, with date_time after date
  def recent_activity(date, limit)

    activities = Array.new
    activities_limit = limit

    moods = Mood.all
    feedbacks = Feedback.all
    comments = Comment.all

    while activities_limit > 0 && (moods.length > 0 || feedbacks.length > 0 || comments.length > 0)

      if feedbacks.length > 0


      else
        if moods.length > 0


        else
          if comments.length > 0

          end


        end


      end
    end
  end

  def self.all
    ('A'..'Z').map { |c| new(c) }
  end


end