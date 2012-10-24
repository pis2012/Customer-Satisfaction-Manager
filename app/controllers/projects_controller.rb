  class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
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
      format.html # new.html.erb
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
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
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
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def show_project_complete

    if !params['default'].nil?
      @profile = Profile.find_by_user_id(current_user)
      @p = Project.find(params['project_id'])
      if !@p.nil?
        @profile.project_id = @p.id
        @profile.save
      end
    end

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
      format.html { render :layout => 'my_projects',:file => 'my_projects/index' }# show_project_complete.html.erb
      format.json { render json: @project }
    end
  end

  def show_project_data
    @project = current_user.profile.project
    @view = {:project => @project, :graph => nil}


    data = Array.new
    axis = Array.new
    count = @project.moods.count
    offset = count > 25 ? count-25 : 0  # Last 25 moods
    @project.moods.order(:created_at).offset(offset).each do |mood|
      data = data + [mood.status]
      axis = axis + ["#{mood.created_at.mday}/#{mood.created_at.mon}"]
    end

    @view[:graph] = Gchart.line(:size => '850x350', :bg => {:color => '76A4FB,1,ffffff,0', :type => 'gradient'}, :graph_bg => 'E5E5E5', :theme => :keynote,
                                :data => data, :axis_with_labels => ['x','y'], :axis_labels => [axis,[1,2,3,4,5,6,7,8,9,10]])

    respond_to do |format|
      format.html { render :layout => false } # show_project_data.html.erb
      format.json { render json: @project }
    end
  end

  def change_profile_project
    proj = Project.find(params[:id])
    current_user.profile.update_attributes(:project => proj)

    redirect_to my_projects_url

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


end
