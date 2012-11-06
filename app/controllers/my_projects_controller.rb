class MyProjectsController < ApplicationController
  before_filter :authenticate_user!

  layout 'my_projects'

  def index
    @project = current_user.profile.project

    respond_to do |format|
      format.html { }
    end
  end

end
