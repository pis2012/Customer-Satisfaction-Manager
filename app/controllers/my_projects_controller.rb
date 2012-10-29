class MyProjectsController < ApplicationController
  before_filter :authenticate_user!

  layout 'my_projects'

  def index

    @project = current_user.profile.project

    @lastmood = @project.moods.order(:created_at).last.get_mood_img
    @view = {:project => @project, :mile1 => nil , :mile2 => nil, :lastmood => @lastmood}

    if !@project.finalized
      next_milestones = @project.get_next_milestones
      if next_milestones[1] == nil
        td = next_milestones[0]
        @view[:mile1] = t('milestone.end_project') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + t("milestone.the") + "#{td.strftime("%Y")}"
      else
        days = next_milestones[0][0]
        hours = next_milestones[0][1]
        name = next_milestones[0][2]
        daystr = days == 1 ? t('milestone.one_day_and') : t('milestone.day_and')
        hoursstr = hours == 1 ? t('milestone.one_hour_to_end') : t('milestone.hours_to_end')
        @view[:mile1] = t('milestone.missing')+" "+" #{days}" + " " + daystr + " #{hours} " + hoursstr +" #{name}."
        td = next_milestones[1][1]
        if next_milestones[1][0] == 1
          @view[:mile2] = t('milestone.Next_milestone') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + t("milestone.the") + "#{td.strftime("%Y")}"
        else
          @view[:mile2] = t('milestone.end_project') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}"  "#{td.strftime("%Y")}"
        end
      end
    end

    @feedbacks = @project.feedbacks

    respond_to do |format|
      format.html { }# show_project_complete.html.erb
      format.json { render json: @project }
    end
  end

end
