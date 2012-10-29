class MyProjectsController < ApplicationController
  before_filter :authenticate_user!

  layout 'my_projects'

  def index
    @project = current_user.profile.project
    @lastmood = @project.moods.order(:created_at).last.get_mood_img
    @view = {:project => @project, :lastmood => @lastmood}

    respond_to do |format|
      format.html { }
    end
  end

end
