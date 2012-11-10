class AdminController < ApplicationController

  before_filter :authenticate_user!

  layout 'admin'

  def index
    @activities = Activity.recent_activity

    respond_to do |format|
      format.html { }
    end
  end

  def show_reports
    @graph = {:bar => Mood.get_graph(), :pie => Project.get_graph()}

    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # reports.html.erb
      end
    end
  end

  def emails_config
    @view = {:properties => CsmProperty.all, :property_updated => false}
    respond_to do |format|
      if request.xhr?
        format.html { render :layout => false } # emails_config.html.erb
      end
    end
  end

  def property_update
    @property = CsmProperty.find(params[:csm_property_id])
    @property.value =  params[:value]
    @property.save
    @view = {:properties => CsmProperty.all, :property_updated => true}
    respond_to do |format|
        format.js { } # emails_config.html.erb
    end

  end


end
