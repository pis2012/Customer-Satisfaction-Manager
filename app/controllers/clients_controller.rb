class ClientsController < ApplicationController

  before_filter :authenticate_user!

  # GET /clients
  def index
    @clients = Client.all
    respond_to do |format|
      if request.xhr?
        format.html # index.html.erb
      end
      format.json { render json: @clients }
    end
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




end
