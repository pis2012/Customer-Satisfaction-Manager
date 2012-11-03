class ProfilesController < ApplicationController

  before_filter :authenticate_user!


  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(current_user.profile.id)
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])
    @user = User.find(params[:profile][:user_id])

    password_changed = !params[:user][:current_password].nil? && !params[:user][:current_password].empty?

    password = params[:user][:password]
    confirmation_password = params[:user][:password_confirmation]

    successfully_updated = if password_changed

      if (password.nil? || password.blank?) && (confirmation_password.nil? || confirmation_password.blank?)

        if password.nil? || password.blank?
          @user.errors.add(:password, I18n.t('activerecord.errors.models.user.attributes.password.blank'))
        end

        if confirmation_password.nil? || confirmation_password.blank?
          @user.errors.add(:confirmation_password, I18n.t('activerecord.errors.models.user.attributes.password_confirmation.blank'))
        end

      else
        @user.update_with_password(params[:user])
      end
    else
       params[:user].delete(:current_password)
       @user.update_without_password(params[:user])
    end

    respond_to do |format|
      if @profile.update_attributes(params[:profile]) && successfully_updated && @user.errors.empty? #&& @user.update_attributes(params[:user])
        format.html { redirect_to '/' }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
