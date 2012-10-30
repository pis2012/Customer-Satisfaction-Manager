  class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  # THIS CONTROLLER HAS TO BE CLEANED FROM UNUSED METHODS AND SCAFFOLDING

  layout false

  # GET /projects
  def index
    @projects = Project.all
    respond_to do |format|
      if request.xhr?
        format.html #{ render :layout => false } # index.html.erb
      end
      format.json { render json:  @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    if !params['default'].nil?
       @profile = Profile.find_by_user_id(current_user)
       @profile.project_id = @project.id
       @profile.save
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # new.html.erb
      end
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        #format.html { redirect_to @project, notice: 'Project was successfully created.' }
        #format.json { render json: @project, status: :created, location: @project }
        @projects = Project.all
        format.json { render action: "index" }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      #format.html { redirect_to projects_url }
      #format.json { head :no_content }
      @projects = User.all
      format.js { render action: "index" }
    end
  end

  def show_project_data
    @project = current_user.profile.project
    @view = {:project => @project, :graph => nil}
    @milestones = @project.milestones
    @view[:graph] = @project.get_mood_graph

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
    @project = current_user.profile.project
    @project.moods.create(:status => params[:new_status], :project => @project)

    @lastmood = @project.moods.order(:created_at).last.get_mood_img

    @view = {:project => @project, :lastmood =>  @lastmood}
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @project }
    end
  end

  def name_filter
    name = params[:name]
    p = Project.arel_table
    @projects = Project.where(p[:name].matches("%#{name}%"))

    respond_to do |format|
      format.js { render action: "index" }
    end
  end


end
