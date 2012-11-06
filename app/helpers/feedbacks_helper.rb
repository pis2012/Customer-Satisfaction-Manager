module FeedbacksHelper

  def get_feedback_date feedback
    "#{t('feedback.uploaded_by')} #{feedback.user.full_name} "                                  + \
    "#{t('feedback.date_on')} #{t("date.#{feedback.created_at.strftime("%A")}")}"               + \
    "#{feedback.created_at.strftime(" %d ")}#{t("date.#{feedback.created_at.strftime("%B")}")}" + \
    "#{feedback.created_at.strftime(" %Y")}"
  end

  def get_feedback_last_comment_date
    "#{t('feedback.last_comment_made_by')} #{@last_comment.user.full_name}, "                               + \
    "#{t("date.#{@last_comment.created_at.strftime("%A")}")} #{@last_comment.created_at.strftime(" %d ")}"  + \
    "#{t("date.#{@last_comment.created_at.strftime("%B")}")} #{@last_comment.created_at.strftime(" %Y")}"   + \
    "#{@last_comment.created_at.strftime((",  %H:%M"))}"
    end

  end
