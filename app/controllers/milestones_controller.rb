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

  # GET /milestones/1
  # GET /milestones/1.json
  def show
    @milestone = Milestone.find(params[:id])

    respond_to do |format|
      if request.xhr?
        format.html # show.html.erb
      end
      format.json { render json: @milestone }
    end
  end

  # GET /milestones/new
  # GET /milestones/new.json
  def new
    @milestone = Milestone.new(:project_id => params[:project_id])

    respond_to do |format|
      format.html { }
      format.json { render json: @milestone }
    end
  end

  # GET /milestones/1/edit
  def edit
    @milestone = Milestone.find(params[:id])
  end

  # POST /milestone
  # POST /milestone.json
  def create
    @milestone = Milestone.new(params[:milestone])

    @milestone.project_id = params[:project_id]

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to :controller => "/projects", :action => "show_project_complete"}
        format.json { render json: @milestone, status: :created, location: @milestone }
      else
        format.html { render action: "new" }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /milestones/1
  # PUT /milestones/1.json
  def update
    @milestone = Milestone.find(params[:id])

    respond_to do |format|
      if @milestone.update_attributes(params[:milestone])
        format.html { redirect_to :controller => "/projects", :action => "show_project_complete" }
        format.json { render json: @milestone, status: :created, location: @milestone }
      else
        format.html { render action: "edit" }
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
      format.html { redirect_to :controller => "/projects", :action => "show_project_complete"}
      format.json { head :no_content }
    end
  end

end
