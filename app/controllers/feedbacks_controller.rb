class FeedbacksController < ApplicationController

  before_filter :authenticate_user!

  layout false
  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
    respond_to do |format|
      if request.xhr?
        format.html # index.html.erb
      end
      format.json { render json: @feedbacks }
    end
  end

  def project_feedbacks
    @feedbacks = Feedback.find_all_by_project_id(params[:project_id])

    respond_to do |format|
      if request.xhr?
      format.html { render action: 'index' }
        end
    end
  end
  Project.where('start_date <= ?', Time.now)

  def date_filter
    date = Time.parse(params[:date])
    @feedbacks = Feedback.where('created_at >= ?', date).where(project_id:params[:project_id])
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js { render action: "index" }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])
    @project = @feedback.project
    @comments = @feedback.comments
    @new_comment = Comment.new

    respond_to do |format|
      if request.xhr?
      format.html # show.html.erb
      end
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.json
  def new
    @feedback = Feedback.new(:project_id => params[:project_id])

    respond_to do |format|
      format.html { }
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/1/edit
  def edit
    @feedback = Feedback.find(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])

    @feedback.project_id = params[:project_id]
    @feedback.user_id = current_user.id

    respond_to do |format|
      if @feedback.save
        User.send_feedback_notification(@feedback)

        @feedbacks = Feedback.find_all_by_project_id(params[:project_id])
        format.js { render action: "index" }
      else
        format.js { }
      end
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.json
  def update
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        @feedbacks = Feedback.find_all_by_project_id(params[:project_id])
        format.js { render action: "index" }
      else
        format.js { }
      end
    end
  end


end
