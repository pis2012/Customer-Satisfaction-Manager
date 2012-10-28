class CommentsController < ApplicationController

  before_filter :authenticate_user!

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    @comment.user_id = current_user.id
    @comment.feedback = Feedback.find(params[:feedback_id])

    respond_to do |format|
      if @comment.save
        @feedback = @comment.feedback
        @new_comment = Comment.new
        format.js { render action: "index" }
      else
        @feedback = @comment.feedback
        @new_comment = @comment
        format.js { render action: "index" }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
