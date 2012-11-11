module FeedbacksHelper

  def get_row_feedback_date(feedback)
    "#{t('feedback.uploaded_by')} #{feedback.user.full_name} "                                  + \
    "#{t('feedback.date_on')} #{t("date.#{feedback.created_at.strftime("%A")}")}"               + \
    "#{feedback.created_at.strftime(" %d ")}#{t("date.#{feedback.created_at.strftime("%B")}")}" + \
    "#{feedback.created_at.strftime(" %Y")}"
  end

  def get_feedback_last_comment_date(feedback)
    comment = feedback.last_comment
    if comment
      "#{t('feedback.last_comment_made_by')} #{comment.user.full_name}, "                         + \
      "#{t("date.#{comment.created_at.strftime("%A")}")} #{comment.created_at.strftime(" %d ")}"  + \
      "#{t("date.#{comment.created_at.strftime("%B")}")} #{comment.created_at.strftime(" %Y")}"   + \
      "#{comment.created_at.strftime((",  %H:%M"))}"
    else
      t('feedback.no_comments')
    end
  end

  def get_feedback_date(feedback)
    "#{t('feedback.create_by')} #{feedback.user.full_name} #{t('feedback.date_on')} "             + \
    "#{t("date.#{feedback.created_at.strftime("%A")}")} #{feedback.created_at.strftime(" %d ")}"  + \
    "#{t("date.#{feedback.created_at.strftime("%B")}")}#{feedback.created_at.strftime(" %Y")}"     + \
    "#{feedback.created_at.strftime(",  %H:%M")}"
  end


end
