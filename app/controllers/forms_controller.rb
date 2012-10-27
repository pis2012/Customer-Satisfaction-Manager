class FormsController < ApplicationController

  before_filter :authenticate_user!

  def index
    forms = Form.all
    @forms_data = []
    forms.each do |form|
      @forms_data += [{:id => form.id, :name => form.name, :total_answers => form.get_total_answers()}]
    end

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # index.html.erb
      end
      format.json { render json: @form_data }
    end
  end

  def new
    @form = Form.new

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # new.html.erb
      end
      format.json { render json: @form }
    end
  end

  def create
    @form = Form.new(params[:form])
    @form.user_id = current_user.id

    respond_to do |format|
      if @form.save
        format.html { redirect_to @forms, notice: 'Form was successfully added.'}
        format.json { render json: @form, status: :created, location: @form }
      else
        format.html { render action: "new" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @form = Form.find(params[:form_id])
    session[:session_drive] = @form.get_session()
    clients = @form.get_clients(session[:session_drive])
    @form_data = {:name => @form.name, :clients => clients}

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_project_data.html.erb
      end
      format.json { render json: @form_data }
    end
  end


  def show_data
    @form = Form.find(params[:form_id])
    session[:session_drive] = @form.get_session() if session[:session_drive] == nil
    @data = @form.get_data(params[:client_name], session[:session_drive])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_data.html.erb
      end
      format.json { render json: @data }
    end
  end

  def show_full_data
    @form = Form.find(params[:form_id])
    session[:session_drive] = @form.get_session() if session[:session_drive] == nil
    @graphs = @form.get_full_data(params[:client_name], session[:session_drive])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_full_data.html.erb
      end
      format.json { render json: @data }
    end
  end




end
