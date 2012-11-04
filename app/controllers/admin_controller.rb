class AdminController < ApplicationController

  before_filter :authenticate_user!

  layout 'admin'

  def index
    @recent = true
    @activities = Activity.recent_activity Date.today - 1.day, 20

    respond_to do |format|
      format.html { }
    end
  end

  def show_reports
    @graph = {:bar => nil, :pie => nil}
    @graph[:bar] = Mood.get_graph()
    @graph[:pie] = Project.get_graph()

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # reports.html.erb
      end
      format.json { render json: @data }
    end
  end

  def emails_config

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # emails_config.html.erb
      end
    end
  end


end
