class MilestonesController < ApplicationController

  before_filter :authenticate_user!

  layout false

  def project_milestones
    @milestones = Milestone.find_all_by_project_id(params[:project_id])

    respond_to do |format|
      if request.xhr?
        format.html { render action: 'index' }
      end
    end
  end


  def new
    @milestone = Milestone.new(:project_id => params[:project_id])

    respond_to do |format|
      if request.xhr?
        format.html { }
      end
      format.js { }
    end
  end

  def create
    @milestone = Milestone.new(params[:milestone])
    @milestone.project_id = params[:project_id]

    respond_to do |format|
      if @milestone.save
        @view = {:project => @milestone.project, :graph => @milestone.project.get_mood_graph}
        format.js
      else
        format.js { render action: 'new' }
      end
    end
  end


  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy

    respond_to do |format|
      if request.xhr?
        @view = {:project => @milestone.project, :graph => @milestone.project.get_mood_graph}
        format.js { render action: "create"}
      else
        format.js { render action: "create"}
      end
    end
  end

end
