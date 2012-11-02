class MilestonesController < ApplicationController

  before_filter :authenticate_user!

  layout false
  # GET /milestones
  # GET /milestones.json
  def index
    @milestones = Milestone.all
    respond_to do |format|
      if request.xhr?
        format.html # index.html.erb
      end
      format.json { render json: @milestones }
    end
  end

  def project_milestones
    @milestones = Milestone.find_all_by_project_id(params[:project_id])

    respond_to do |format|
      if request.xhr?
        format.html { render action: 'index' }
      end
    end
  end

  # GET /milestones/new
  # GET /milestones/new.json
  def new
    @milestone = Milestone.new(:project_id => params[:project_id])

    respond_to do |format|
      if request.xhr?
        format.html { }
      end
    end
  end

  # POST /milestone
  # POST /milestone.json
  def create
    @milestone = Milestone.new(params[:milestone])
    @milestone.project_id = params[:project_id]

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to my_projects_path }
        format.json { render json: @milestone, status: :created, location: @milestone }
      else
        format.html { render action: "new" }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milestones/1
  # DELETE /milestones/1.json
  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy

    respond_to do |format|
      #format.html { redirect_to milestones_url }
      format.html { redirect_to my_projects_path }
      format.json { head :no_content }
    end
  end

end
