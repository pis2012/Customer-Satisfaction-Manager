class FormsController < ApplicationController

  before_filter :authenticate_user!

  layout false

  def index
    @forms = Form.all

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # index.html.erb
      end
      format.js { render js: @form_data }
    end
  end

  def new
    @form = Form.new

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # new.html.erb
      end
      format.js { render js: @form }
    end
  end

  def create
    auth_err = false
    exists = true
    begin
      session = GoogleDrive.login(params["form"]["email"],params["form"]["password"])
    rescue
      params["form"].delete("password")
      @form = Form.new(params["form"])
      auth_err = true
    else
      params["form"].delete("password")
      @form = Form.new(params["form"])
      auth_tokens = session.auth_tokens()
      @form.wise_token = auth_tokens[:wise]
      @form.writely_token = auth_tokens[:writely]
      begin
      @form.update_total_answers session
      rescue
        exists = false
      end
    end
    respond_to do |format|
      duplicated = false
      saved = false
      if exists
        begin
          saved = @form.save
        rescue
          duplicated = true
        end
      end
      if saved
        @forms = Form.all
        format.js { render action: "index" }
      else
        if auth_err
          @form.errors[:base] << "authentication"
        elsif duplicated
          @form.errors[:base] << "duplicated"
        elsif !exists
          @form.errors[:base] << "not_exists"
        end
        format.js { render action: "new" }
      end
    end
  end

  def show
    @form = Form.find(params[:id])
    session[:session] = @form.get_session
    clients = @form.get_clients session[:session]
    @form_data = {:name => @form.name, :clients => clients}

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_project_data.html.erb
      end
      format.js { render js: @form_data }
    end
  end


  def show_data
    @form = Form.find(params[:id])
    session[:session] = @form.get_session if session[:session] == nil
    @data = @form.get_data(params[:client_name], session[:session])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_data.html.erb
      end
      format.js { render js: @data }
    end
  end

  def show_full_data
    @form = Form.find(params[:id])
    session[:session] = @form.get_session if session[:session] == nil
    @graphs = @form.get_full_data(params[:client_name], session[:session])

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # show_full_data.html.erb
      end
      format.js { render js: @data }
    end
  end

  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    respond_to do |format|
      if request.xhr?
        @forms = Form.where(:user_id => current_user.id)
        format.js { render action: "index" }
      end
    end
  end


end
