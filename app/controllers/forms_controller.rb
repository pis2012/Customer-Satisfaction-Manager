class FormsController < ApplicationController

  def index


  end

  def create
    @form = Form.new(params[:form])
    @form.user_id = current_user.id

    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: 'Form was successfully added.' }
        format.json { render json: @form, status: :created, location: @form }
      else
        format.html { render action: "new" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end







end
