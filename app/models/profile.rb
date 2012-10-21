class Profile < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  attr_accessible :user, :project, :skype_usr, :user_id, :project_id, :avatar, :feedbacks_notifications,
                  :comments_notifications, :show_gravatar


  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "80x80>" }

  validates :user, :project, :presence  => true

  validates_attachment :avatar,
                       :content_type => { :content_type => [ "image/jpeg","image/png","image/gif" ] },
                       :size => { :in => 0..2.megabytes }



end