class Profile < ActiveRecord::Base
  attr_accessible :last_login_date, :project_id, :user_id

  belongs_to :user
  belongs_to :project

end
