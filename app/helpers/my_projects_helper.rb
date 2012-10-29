module MyProjectsHelper


  def get_milestones_data
    res = [nil,nil]
    if !@project.finalized
      next_milestones = @project.get_next_milestones
      if next_milestones[1] == nil
        td = next_milestones[0]
        res[0] = t('milestone.end_project') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + t("milestone.the") + "#{td.strftime("%Y")}"
      else
        days = next_milestones[0][0]
        hours = next_milestones[0][1]
        name = next_milestones[0][2]
        daystr = days == 1 ? t('milestone.one_day_and') : t('milestone.day_and')
        hoursstr = hours == 1 ? t('milestone.one_hour_to_end') : t('milestone.hours_to_end')
        res[0] = t('milestone.missing')+" "+" #{days}" + " " + daystr + " #{hours} " + hoursstr +" #{name}."
        td = next_milestones[1][1]
        if next_milestones[1][0] == 1
          res[1] = t('milestone.Next_milestone') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + t("milestone.the") + "#{td.strftime("%Y")}"
        else
          res[1] = t('milestone.end_project') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}"  "#{td.strftime("%Y")}"
        end
      end
    end
    res
  end



end
