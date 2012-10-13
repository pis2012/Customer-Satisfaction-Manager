class Form < ActiveRecord::Base

  belongs_to :user

  # :name := Name of the form(spreadsheet) in the google drive account
  # :email := Email corresponding to the google drive account
  # :password := Password corresponding to the google drive account
  attr_accessible :name, :email, :password, :user_id

  validates :email, :name, :password, :user_id, :presence => true


  # Returns all the graphics with all the data (answers) of the form\
  # that the client with client_id answered
  def get_data client_id
    client_name = Client.find(client_id).name

    session = GoogleDrive.login(self.email, self.password)
    ws = session.spreadsheet_by_title(self.name)





  end




end
