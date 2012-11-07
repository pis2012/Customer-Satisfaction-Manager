class CallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :verify_authenticity_token, :only => [:google]

  def google
    @user = User.find_for_open_id_google(request.env["omniauth.auth"], current_user)

    if !@user.nil? && !@user.disable?
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        #session["devise.google_data"] = request.env["omniauth.auth"]
        #redirect_to new_user_registration_url
        flash[:alert] = t("devise.failure.user.invalid")
        redirect_to new_user_session_path
      end
    else
        if !@user.nil?
          flash[:alert] = t("devise.failure.user.disable")
        else
          flash[:alert] = t("devise.failure.user.email_not_allowed")
        end
        redirect_to new_user_session_path
    end
  end

  skip_before_filter :verify_authenticity_token, :only => [:google_apps]

  def google_apps
    @user = User.find_for_open_id_google_apps(request.env["omniauth.auth"], current_user)

    if !@user.disable?
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        #session["devise.google_data"] = request.env["omniauth.auth"]
        #redirect_to new_user_registration_url
        flash[:alert] = t("devise.failure.user.invalid")
        redirect_to new_user_session_path
      end
    else
      flash[:alert] = t("devise.failure.user.disable")
      redirect_to new_user_session_path
    end

  end

end