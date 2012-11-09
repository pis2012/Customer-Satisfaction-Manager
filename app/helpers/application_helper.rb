module ApplicationHelper
  include MyProjectsHelper

  def mail_mood_face_link(mood, attachments, url)
    html = content_tag :td, :style => "width: 100px; text-align: center;" do
      html = link_to url do
          html = image_tag mail_mood_face(mood, attachments)
          html
      end
      html
    end
    raw html
  end

  def mail_mood_face(mood, attachments)
    raw attachments[mood].url
  end

end
