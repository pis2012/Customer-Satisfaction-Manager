  class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  layout false

  # GET /projects
  def index
    @projects = Project.all
    respond_to do |format|
      if request.xhr?
        format.html { } # index.html.erb
      end
      format.json { render json: @projects }
    end
  end

  # GET /projects/filter
  def text_filter
    @last_filter_text = params[:projects_filter_text]
    @projects = Project.related_projects @last_filter_text
    respond_to do |format|
      format.js { render action: "index" }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @clients = Client.all

    respond_to do |format|
      if request.xhr?
        format.html { } # new.html.erb
      end
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @clients = Client.all

    respond_to do |format|
      if request.xhr?
        format.html { } # new.html.erb
      end
      format.json { render json: @project }
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.finalized = false
    @project.end_date = params[:end_date]
    respond_to do |format|
      if @project.save
        mood = @project.moods.create(:status => 5, :project => @project)
        @project.mood = mood
        @project.save
        get_index_projects
        format.js { render action: "index" }
      else
        @clients = Client.all
        format.js {}
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    @project.end_date = params[:end_date]
    respond_to do |format|
      if @project.update_attributes(params[:project])
        get_index_projects
        format.js { render action: "index" }
      else
        @clients = Client.all
        format.js {}
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.destroy
        get_index_projects
        format.js { render action: "index" }
      else
        @clients = Client.all
        format.js { render action: "update" }
      end
    end
  end

  def show_project_data
    @project = Project.find(params[:project_id])
    @graph = @project.get_mood_graph

    respond_to do |format|
      format.html { render :layout => false } # show_project_data.html.erb
      format.json { render json: @project }
    end
  end

  def change_profile_project
    project = Project.find(params[:project_id])
    if !current_user.client? || (current_user.client? && project.client_id == current_user.client_id)
      current_user.profile.update_attributes(:project => project)
      redirect_to my_projects_url
    else
      not_found
    end
  end

  def change_mood
    @project = Project.find(params[:project_id])
    mood = @project.moods.create(:status => params[:new_status], :project => @project)
    @project.mood = mood
    @project.save

    @view = {:project => @project}
    respond_to do |format|
      format.html { render :template => "moods/_form", :layout => false }
    end
  end

  def change_any_project_mood
    project = Project.find(params[:project_id])
    if !current_user.client? || (current_user.client? && project.client_id == current_user.client_id)
      current_user.profile.update_attributes(:project => project)
      mood = project.moods.create(:status => params[:new_status], :project => @project)
      project.mood = mood
      project.save
      redirect_to my_projects_url
    else
      not_found
    end
  end

  private

    def get_index_projects
      @projects = Project.all
    end

end
