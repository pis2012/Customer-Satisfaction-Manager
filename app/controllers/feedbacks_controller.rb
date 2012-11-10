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
    @feedbacks = Feedback.project_feedbacks params[:project_id]

    respond_to do |format|
      if request.xhr?
        format.html { render action: 'index' }
      end
    end
  end

  def date_filter
    @feedbacks = Feedback.date_filter_feedbacks(params[:project_id], Time.parse(params[:date]))

    respond_to do |format|
      format.js { render action: "index" }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])
    @comment = Comment.new

    respond_to do |format|
      if request.xhr?
        format.html # show.html.erb
      end
      format.json { render json: @feedback }
    end
  end

  def new
    @feedback = Feedback.new(:project_id => params[:project_id])
    @feedback_types = current_user.possible_feedback_types
    respond_to do |format|
      if request.xhr?
        format.html {}
      end
      format.json { render json: @feedback }
    end
  end

  def edit
    @feedback_types = current_user.possible_feedback_types
    @feedback = Feedback.find(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])


    respond_to do |format|
      if @feedback.save
        # User.send_feedback_notification(@feedback)
        Thread.new(@feedback) { |feedback|
          User.send_feedback_notification(feedback)
        }
        @feedbacks = Feedback.project_feedbacks @feedback.project_id
        format.js { render action: "index" }
      else
        @feedback_types = current_user.possible_feedback_types
        format.js {}
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
        @feedback_types = current_user.possible_feedback_types
        format.js {}
      end
    end
  end


end
