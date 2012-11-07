class ClientsController < ApplicationController

  before_filter :authenticate_user!

  # GET /clients
  def index
    @clients = Client.all

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false }
      end
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false }
      end
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  def new
    @client = Client.new

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # new.html.erb
      end
      format.json { render json: @client }
    end

  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # edi.html.erb
      end
      format.json { render json: @client }
    end

  end

  # POST /clients
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        @clients = Client.all
        format.js { render :action => "index" }
      else
        format.js {}
      end
    end
  end

  # PUT /clients/1
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        @clients = Client.all
        format.js { render :action => "index" }
      else
        format.js {}
      end
    end
  end

  # DELETE /clients/1
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      @clients = Client.all
      format.js { render :action => "index" }
    end
  end

  def name_filter
    @last_filter_text = params[:clients_filter_text]
    @clients = Client.text_filter_clients @last_filter_text

    respond_to do |format|
      format.js { render :action => "index" }
    end
  end


end
