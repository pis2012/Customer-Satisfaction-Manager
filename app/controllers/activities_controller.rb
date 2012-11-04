class ActivitiesController < ApplicationController

  before_filter :authenticate_user!

  layout false

  def index
    @activities = Activity.recent_activity Date.today - 1.day, 20
    @recent = true

    respond_to do |format|
      if request.xhr?
        format.html # index.html.erb
      end
      format.json { render json: @activities }
    end
  end

  def activities_filter
    @activities = Activity.activity_filter params[:activities_filter_text]
    @recent = false
    respond_to do |format|
      format.js { }
    end
  end

end
