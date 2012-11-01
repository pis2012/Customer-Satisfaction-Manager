class AdminController < ApplicationController

  before_filter :authenticate_user!

  layout 'admin'

  def index
    @users =  User.all
    @activities = Activity.recent_activity Date.today, 12

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




end
