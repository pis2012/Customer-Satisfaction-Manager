class ActivitiesController < ApplicationController

  before_filter :authenticate_user!

  layout false

  def index
    @activities = Activity.recent_activity

    respond_to do |format|
      if request.xhr?
        format.html # index.html.erb
      end
      format.json { render json: @activities }
    end
  end

  def activities_filter
    @activities = Activity.activity_filter params[:activities_filter_text]

    respond_to do |format|
      format.js { }
    end
  end

end
