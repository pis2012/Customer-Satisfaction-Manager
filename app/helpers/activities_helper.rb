module ActivitiesHelper

  def activity_avatar(object)
    case object.class.name
      when 'Feedback', 'Comment', 'Mood', 'Project'
        link_to activity_link object do
          activity_image_tag object
        end
      when 'User'
        link_to "", :href => "#show-user" + object.id.to_s, :class => "show-user-link", :data => { :url => user_path(object) } do
          activity_image_tag object
        end
      when 'Client'
        link_to "", :href => "#show-client" + object.id.to_s, :class => "show-client-link", :data => { :url => client_path(object) } do
          activity_image_tag object
        end
      else
        ""
    end
  end

  def activity_action(object, recent)
    case object.class.name
      when 'Feedback', 'Comment', 'Mood', 'Project'
        link_to activity_link object do
          truncate(strip_tags(activity_action_name(object, recent)), :length => 80)
        end
      when 'User'
        link_to "", :href => "#show-user" + object.id.to_s, :class => "show-user-link", :data => { :url => user_path(object) } do
          truncate(strip_tags(activity_action_name(object, recent)), :length => 80)
        end
      when 'Client'
        link_to "", :href => "#show-client" + object.id.to_s, :class => "show-client-link", :data => { :url => client_path(object) } do
          truncate(strip_tags(activity_action_name(object, recent)), :length => 80)
        end
      else
        ""
    end
  end





  def user_image_tag(user)
    if user.profile.show_gravatar
      gravatar_image_tag user.profile.user.email.gsub('spam', 'mdeering'), :alt => user.full_name,
                         :class => 'activity_image'
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
      image_tag 'client.png', :class => 'activity_image'
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

  def activity_action_name(object,recent)
    case object.class.name
    when 'Feedback'
      if recent
        "#{t('activity.new_feedback')} #{object.subject} #{t('activity.on')} #{object.project.name}"
      else
        "#{t('activity.feedback')}: #{object.subject} #{t('activity.on')} #{object.project.name}"
      end
    when 'Mood'
      "#{t('activity.mood_update')} #{object.project.name}!"
    when 'Comment'
      if recent
        "#{t('activity.new_comment')} #{object.feedback.subject}"
      else
        "#{t('activity.comment')} #{object.feedback.subject}"
      end
    when 'Project'
      if recent
        "#{t('activity.new_project')} #{object.name} #{t('activity.for')} #{object.client.name}"
      else
        "#{t('activity.project')} #{object.name}, #{object.client.name}"
      end
    when 'User'
      if object.admin?
        user_role = t('activity.admin')
      elsif object.client?
        user_role = object.client.name
      else
        user_role = t('activity.employee')
      end
      if recent
        "#{t('activity.new_user')} #{object.full_name}, #{user_role}"
      else
        "#{t('activity.user')} #{object.full_name}, #{user_role}"
      end
    when 'Client'
      if recent
        "#{t('activity.new_client')} #{object.name}"
      else
        "#{t('activity.client')} #{object.name}"
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
