class CommentsController < ApplicationController

  before_filter :authenticate_user!

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        # User.send_comment_notification(@comment)
        Thread.new(@comment) { |comment|
          User.send_comment_notification(comment)
        }

        @feedback = Feedback.find(@comment.feedback_id)
        @comment = Comment.new
        format.js { render action: "index" }
      else
        @feedback = Feedback.find(@comment.feedback_id)
        format.js { render action: "index" }
      end
    end
  end

end
