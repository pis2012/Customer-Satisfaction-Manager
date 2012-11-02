module MyProjectsHelper

  def get_milestones_data
    res = [nil,nil]
    if !@project.finalized
      next_milestones = @project.get_next_milestones
      if next_milestones[0] != nil
        if next_milestones[1] == nil
          td = next_milestones[0]
          res[0] = t('milestone.end_project') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + ", #{td.strftime("%Y")}"
        else
          days = next_milestones[0][0]
          hours = next_milestones[0][1]
          name = next_milestones[0][2]
          daystr = days == 1 ? t('milestone.one_day_and') : t('milestone.day_and')
          hoursstr = hours == 1 ? t('milestone.one_hour_to_end') : t('milestone.hours_to_end')
          res[0] = t('milestone.missing')+" "+" #{days}" + " " + daystr + " #{hours} " + hoursstr +" #{name}."
          td = next_milestones[1][1]
          if next_milestones[1][0] == 1
            res[1] = t('milestone.Next_milestone') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + ", #{td.strftime("%Y")}"
          else
            res[1] = t('milestone.end_project') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}"  ", #{td.strftime("%Y")}"
          end
        end
      end
    end
    res
  end

  def self.send_reminder_email
    daysWithNoActivity = 2
    daysSinceLastEmail = 2

    limitEmailDate = Time.now.advance(days: -daysSinceLastEmail)
    projects = Project.get_projects_with_no_activity(daysWithNoActivity)
    emails = []
    projects.each do |project|
      if (project.last_reminder_email_sent.nil? or project.last_reminder_email_sent < limitEmailDate)
        user = project.get_random_user
        if (user)
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
