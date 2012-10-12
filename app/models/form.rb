class Form < ActiveRecord::Base

  belongs_to :user

  # :name := Name of the form(spreadsheet) in the google drive account
  # :email := Email corresponding to the google drive account
  # :password := Password corresponding to the google drive account
  attr_accessible :name, :email, :password, :user_id

  validates :email, :name, :password, :user_id, :presence => true

end
