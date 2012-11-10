class UsersController < ApplicationController


  layout false
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      if request.xhr?
        format.html # index.html.erb
      end
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      if request.xhr?
        format.html # show.html.erb
      end
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.skip_confirmation!
    @user.role = Role.find_by_name Role::CLIENT_ROLE


    respond_to do |format|
      if @user.save
        @user.create_profile
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        #format.json { render json: @user, status: :created, location: @user }
        @users = User.all
        format.js { render action: "index" }
      else
        #format.html { render action: "new" }
        format.js { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @profile = Profile.find @user.profile.id

    if @user.mooveit? && !params[:is_admin].nil?
      @user.role = Role.find_by_name Role::ADMIN_ROLE
    end

    if @user.admin? && params[:is_admin].nil?
      @user.role = Role.find_by_name Role::MOOVEIT_ROLE
    end


    respond_to do |format|
      if @user.update_without_password(params[:user]) && @profile.update_attributes(params[:profile])
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        #format.json { head :no_content }
        @users = User.all
        format.js { render action: "index" }
      else
        #format.html { render action: "edit" }
        format.js { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      #format.html { redirect_to users_url }
      #format.json { head :no_content }
      @users = User.all
      format.js { render action: "index" }
    end
  end

  def name_filter
    @last_filter_text = params[:users_filter_text]
    @users = User.related_users @last_filter_text

    respond_to do |format|
      format.js { render action: "index" }
    end
  end

end
