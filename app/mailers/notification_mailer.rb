class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def feedback_notification_email(feedback,user)
    @feedback = feedback
    @project = Project.find(feedback.project_id)
    @user = user
    @profile = user.profile
    attachments.inline['logo'] = {
        :data => File.read("#{Rails.root.to_s + '/app/assets/images/moove-it.png'}"),
        :mime_type => "image/png",
        :encoding => "base64"
    }
    attachments.inline['header_bg'] = {
        :data => File.read("#{Rails.root.to_s + '/app/assets/images/header_bg.png'}"),
        :mime_type => "image/png",
        :encoding => "base64"
    }
    mail(:to => user.email, :subject => "New Feedback for your project in Moove-it")
  end

  def comment_notification_email(comment,user)
    @comment = comment
    @project = Project.find(comment.feedback.project_id)
    @user = user
    @profile = user.profile
    attachments.inline['logo'] = {
        :data => File.read("#{Rails.root.to_s + '/app/assets/images/moove-it.png'}"),
        :mime_type => "image/png",
        :encoding => "base64"
    }
    attachments.inline['header_bg'] = {
        :data => File.read("#{Rails.root.to_s + '/app/assets/images/header_bg.png'}"),
        :mime_type => "image/png",
        :encoding => "base64"
    }
    mail(:to => user.email, :subject => "New Comment for your project in Moove-it")
  end

end
