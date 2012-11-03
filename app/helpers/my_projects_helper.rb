module MyProjectsHelper

  def self.send_reminder_email
    days = 30

    lastMoods = Mood.get_mood_in_last_days(days)
    projects = Project.where("finalized = 0 and id not in (:projects)",{projects: lastMoods.group_by {|i| i.project_id}.keys})
    emails = []
    projects.each do |project|
      user = project.get_random_user
      NotificationMailer.reminder_email(project,user).deliver if (user)
      emails.append user.email if (user)
    end

    emails
  end

end
