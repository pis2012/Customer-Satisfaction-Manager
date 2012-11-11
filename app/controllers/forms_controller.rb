class FormsController < ApplicationController

  before_filter :authenticate_user!

  layout false

  def index
    @forms = Form.all

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # index.html.erb
      end
    end
  end

  def new
    @form = Form.new

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # new.html.erb
      end
    end
  end

  def create
    @form = Form.new
    exists = @form.init(params)

    respond_to do |format|
      if exists
        begin
          @form.save
          @forms = Form.all
          format.js { render action: "index" }
        rescue
          @form.errors[:base] << "duplicated"
        end
      end
      format.js { render action: "new" }
    end
  end

  def show
    @form = Form.find(params[:id])
    begin
      # If fails then the form does not exist anymore?
      session[:worksheet] = @form.get_session_worksheet
      clients = @form.get_clients(session[:worksheet])
      @data = @form.get_data(params[:client_name],session[:worksheet])
    rescue
      @form.errors[:base] << "not_exists_anymore?"
      clients = []
    end
    @form_data = {:name => @form.name, :clients => clients}
    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_project_data.html.erb
      end
    end
  end


  def show_data
    @form = Form.find(params[:id])
    @data = @form.get_data(params[:client_name], session[:worksheet])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_data.html.erb
      end
    end
  end

  def show_full_data
    @form = Form.find(params[:id])
    @graphs = @form.get_full_data(params[:client_name], session[:worksheet])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_full_data.html.erb
      end
    end
  end

  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    respond_to do |format|
      if request.xhr?
        @forms = Form.all
        format.js { render action: "index" }
      end
    end
  end


end
