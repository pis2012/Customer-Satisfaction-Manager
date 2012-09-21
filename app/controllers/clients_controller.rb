class ClientsController < ApplicationController

  # GET /clients
  def index
    @clients = Client.all
  end

  # GET /clients/1
  def show
    @client = Client.find(params[:id])
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /clients/1
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /clients/1
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    redirect_to clients_url
  end

  def show_project
    project_id = Profile.find_by_user_id(current_user.id).project_id
    @project = Project.find(project_id)
    @milestones = Milestone.find_all_by_project_id(@project.id)
    @feedbacks = Feedback.find_all_by_project_id(@project.id)
  end


end
