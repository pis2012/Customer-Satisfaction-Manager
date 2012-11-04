module ActivitiesHelper

  def user_image_tag(user)
    if user.profile.show_gravatar
      gravatar_image_tag user.profile.user.email.gsub('spam', 'mdeering'), :alt => user.full_name, :class => 'activity_image'
    else
      if user.profile.avatar.file?
        image_tag user.profile.avatar.url(:medium), :alt => user.full_name, :class => 'activity_image'
      else
        image_tag 'default_user_pic.png', :alt => user.full_name, :class => 'activity_image'
      end
    end
  end

  def activity_image_tag(object)
    case object.class.name
    when 'Feedback'
      image_tag object.feedback_type.image_url, :class => 'activity_image'
    when 'Mood'
      image_tag 'moods/normal/' + object.get_mood_img, :class => 'activity_image'
    when 'Comment'
      user_image_tag object.user
    when 'Project'
      image_tag 'moods/normal/' + object.mood.get_mood_img, :class => 'activity_image'
    when 'User'
      user_image_tag object
    when 'Client'
      image_tag 'default_user_pic.png', :class => 'activity_image'
    else
      ""
    end
  end

  def activity_link(object)
    case object.class.name
    when 'Feedback'
      "/my_projects/#{object.project.id}"
    when 'Mood'
      "/my_projects/#{object.project.id}"
    when 'Comment'
      "/my_projects/#{object.feedback.project.id}"
    when 'Project'
      "/my_projects/#{object.id}"
    else
      ""
    end
  end

  def activity_action(object)
    case object.class.name
    when 'Feedback'
      if @recent
        "New feedback #{object.subject} on #{object.project.name}"
      else
        "Feedback: #{object.subject} on #{object.project.name}"
      end
    when 'Mood'
      "Mood update on project #{object.project.name}!"
    when 'Comment'
      if @recent
        "New comment on feedback #{object.feedback.subject}"
      else
        "Comment on feedback #{object.feedback.subject}"
      end
    when 'Project'
      if @recent
        "New project #{object.name} for #{object.client.name}"
      else
        "Project #{object.name}, #{object.client.name}"
      end
    when 'User'
      if @recent
        "New user #{object.full_name}"
      else
        if object.admin?
          user_role = "Administrator"
        elsif object.client?
          user_role = object.client.name
        else
          user_role = "Moove-IT Employee"
        end
        "User #{object.full_name}, #{user_role}"
      end
    when 'Client'
      if @recent
        "New client #{object.name}"
      else
        "Client #{object.name}"
      end
    else
      ""
    end
  end

  def activity_date(object)
    case object.class.name
    when 'Feedback'
      t('activity.authored_by') + " " + object.user.full_name + " " + t('activity.date_on') + "   " \
      + t("date." + "#{object.created_at.strftime("%A")}") + object.created_at.strftime(" %d ")     \
      + t("date." + "#{object.created_at.strftime("%B")}") + object.created_at.strftime(" %Y")      \
      + object.created_at.strftime((" ,  %H:%M"))
    when 'Mood', 'Client'
      t("date." + "#{object.created_at.strftime("%A")}") + object.created_at.strftime(" %d ")       \
      + t("date." + "#{object.created_at.strftime("%B")}") + object.created_at.strftime(" %Y")      \
      + object.created_at.strftime((" ,  %H:%M"))
    when 'Comment'
      t('activity.authored_by') + " " + object.user.full_name + " " + t('activity.date_on') + "   " \
      + t("date." + "#{object.created_at.strftime("%A")}") + object.created_at.strftime(" %d ")     \
      + t("date." + "#{object.created_at.strftime("%B")}") + object.created_at.strftime(" %Y")      \
      + object.created_at.strftime((" ,  %H:%M"))
    when 'Project'
      t("date." + "#{object.created_at.strftime("%A")}") + object.created_at.strftime(" %d ")       \
      + t("date." + "#{object.created_at.strftime("%B")}") + object.created_at.strftime(" %Y")      \
      + object.created_at.strftime((" ,  %H:%M"))
    when 'User'
      t("date." + "#{object.created_at.strftime("%A")}") + object.created_at.strftime(" %d ")       \
      + t("date." + "#{object.created_at.strftime("%B")}") + object.created_at.strftime(" %Y")      \
      + object.created_at.strftime((" ,  %H:%M"))
    else
      ""
    end
  end

  def activity_content(object)
    case object.class.name
    when 'Feedback'
      object.content
    when 'Comment'
      object.content
    when 'Project'
      object.description
    else
      ""
    end
  end

end
