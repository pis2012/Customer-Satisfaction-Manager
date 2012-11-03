class MyProjectsController < ApplicationController
  before_filter :authenticate_user!

  layout 'my_projects'

  def index
    @project = Project.find(current_user.profile.project.id)
    @lastmood = @project.moods.first.get_mood_img
    @view = {:project => @project, :lastmood => @lastmood}

    respond_to do |format|
      format.html { }
    end
  end

end
