module MyProjectsHelper

  def self.send_reminder_email
    daysWithNoActivity = Integer(CsmProperty.get_property("DaysWithoutActivityForAProject","30"))
    daysSinceLastEmail = Integer(CsmProperty.get_property("DaysBetweenReminderEmailForAProject","30"))

    limitEmailDate = Time.now.advance(days: -daysSinceLastEmail)
    projects = Project.get_projects_with_no_activity(daysWithNoActivity)
    emails = []
    projects.each do |project|
      if project.last_reminder_email_sent.nil? or project.last_reminder_email_sent < limitEmailDate
        user = project.get_random_user
        if user
          NotificationMailer.reminder_email(project,user).deliver
          project.last_reminder_email_sent = Time.now
          project.save
          emails.append user.email
        end

      end
    end

    emails
  end

end
