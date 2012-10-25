class FormsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @forms = Form.all


  end

  def new
    @form = Form.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form }
    end
  end

  def create
    @form = Form.new(params[:form])
    @form.user_id = current_user.id

    respond_to do |format|
      if @form.save
        format.html { redirect_to @forms, notice: 'Form was successfully added.' }
        format.json { render json: @form, status: :created, location: @form }
      else
        format.html { render action: "new" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    form = Form.find(params[:id])
    @graphs = form.get_data(params[:client_id])



  end







end
