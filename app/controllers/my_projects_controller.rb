class MyProjectsController < ApplicationController
  before_filter :authenticate_user!

  layout 'my_projects'

  def index

    @project = current_user.profile.project

    @lastmood = @project.moods.order(:created_at).last.get_mood_img
    @view = {:project => @project, :mile1 => nil , :mile2 => nil, :lastmood => @lastmood}

    if !@view[:project].finalized
      current_date = Time.now.to_date
      miles = @project.milestones.order(:target_date).select {|mile| mile.target_date > current_date}
      if (miles.count > 0)
        td = miles.first.target_date
        sec = (td.to_time - current_date.to_time).to_i
        min = (sec/60).to_i
        hours = (min/60).to_i
        days = (hours/24).to_i
        @view[:mile1] = t('milestone.missing')+" "+" #{days}"+" "+t('milestone.day_and')+" #{hours%24} " +t('milestone.hours_to_end') +" #{miles.first.name}."
        if (miles.count > 1)
          td = miles.second.target_date
          @view[:mile2] =  t('milestone.Next_milestone') +": " +t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}"
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
