module ProjectsHelper

  def get_project_end_date(project)
    td = project.end_date
    "#{t("date.#{td.strftime("%A")}")} #{td.strftime(" %d ")}" +
    "#{t("date.#{td.strftime("%B")}")}, #{td.strftime(" %Y")}"
  end

  def get_project_last_feedback_date(project)
    feedback = project.last_feedback
    if feedback
      "#{t('project.last_feedback_made_by')} #{feedback.user.full_name}, "                          + \
      "#{t("date.#{feedback.created_at.strftime("%A")}")} #{feedback.created_at.strftime(" %d ")}"  + \
      "#{t("date.#{feedback.created_at.strftime("%B")}")} #{feedback.created_at.strftime(" %Y")}"   + \
      "#{feedback.created_at.strftime((",  %H:%M"))}"
    else
      t('project.no_feedbacks')
    end
  end

  def get_project_short_end_date
    @project.new_record? ? (Time.now + 1.year).strftime("%d/%m/%Y") : @project.end_date.strftime("%d/%m/%Y")
  end

end
