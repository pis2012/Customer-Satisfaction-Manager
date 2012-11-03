class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
  helper :application

  def addInlineImage(name,location)
    attachments.inline[name] = {
        :data => File.read("#{Rails.root.to_s + location}"),
        :mime_type => "image/png",
        :encoding => "base64"
    }
  end

  def feedback_notification_email(feedback,user)
    @feedback = feedback
    @project = Project.find(feedback.project_id)
    @user = user
    @profile = user.profile
    addInlineImage('logo','/app/assets/images/moove-it.png')

    mail(:to => user.email, :subject => "New Feedback for your project in Moove-iT")
  end

  def comment_notification_email(comment,user)
    @comment = comment
    @project = Project.find(comment.feedback.project_id)
    @user = user
    @profile = user.profile
    addInlineImage('logo','/app/assets/images/moove-it.png')
    mail(:to => user.email, :subject => "New Comment for your project in Moove-iT")
  end

  def reminder_email(project,user)
    @project = project
    @user = user
    @profile = user.profile
    addInlineImage('logo','/app/assets/images/moove-it.png')

    addInlineImage('Angry','/app/assets/images/moods/small/1.png')
    addInlineImage('Disappointed','/app/assets/images/moods/small/2.png')
    addInlineImage('Indifferent','/app/assets/images/moods/small/3.png')
    addInlineImage('Pleased','/app/assets/images/moods/small/4.png')
    addInlineImage('Happy','/app/assets/images/moods/small/5.png')

    mail(:to => user.email, :subject => "Friendly reminder from Moove-iT")
  end

end
