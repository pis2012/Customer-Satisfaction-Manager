class Profile < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  attr_accessible :user, :project,
                  :last_login_date, :image_url, :skype_usr, :project_id, :user_id

  validates :user, :project, :last_login_date, :presence  => true

  validates :image_url, :format => {
      :with  => %r{(\.(gif|jpg|png)$|)}i,
      :message => 'must be a URL for GIF, JPG or PNG image.'
  }

end