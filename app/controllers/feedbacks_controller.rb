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
    fecha = Time.parse(params[:date])
    @feedbacks = Feedback.where('created_at >= ?', fecha).where(project_id:params[:project_id])
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js {}
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])

    @comment  = Comment.find_all_by_feedback_id(@feedback.id)

    @commentNew = Comment.new

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
    @feedback.user_id= current_user.id

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to :controller => "/projects", :action => "show_project_complete" }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.json
  def update
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        format.html { redirect_to :controller => "/projects", :action => "show_project_complete" }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "edit" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedbacks_url }
      format.json { head :no_content }
    end
  end


end
