class Form < ActiveRecord::Base

  # :name := Name of the form(spreadsheet) in the google drive account
  # :email := Email corresponding to the google drive account
  # :password := Password corresponding to the google drive account
  attr_accessible :name, :email, :wise_token, :actual_total_answers, :writely_token

  validates :email, :name, :presence => true

  def get_session
    GoogleDrive.restore_session({:wise => self.wise_token.to_s, :writely => self.writely_token.to_s})
  end

  # Validates, initializes the form and return true if is valid
  def init_validate session
    auth_tokens = session.auth_tokens()
    self.wise_token = auth_tokens[:wise]
    self.writely_token = auth_tokens[:writely]
    # First worksheet
    ws = session.spreadsheet_by_title(self.name).worksheets[0]
    self.update_total_answers ws
    self.is_valid? ws
  end

  def is_valid? ws
    valid = false
    if ws[1,1].include? "Marca temporal"
      # Get the column number of the users email
      email_user_column = 1
      for col in 2..ws.num_cols do
        if ws[1,col].include? "Please write your email"
          email_user_column = col
          break
        end
      end
      if email_user_column != 1
        valid = true
      end
    end
    valid
  end

  # Returns the total answers in the form
  def update_total_answers ws
    self.actual_total_answers = ws.num_rows-1
  end


  # Returns the clients that answered the form
  def get_clients session
    # First worksheet
    ws = session.spreadsheet_by_title(self.name).worksheets[0]
    #update total answers
    self.update_total_answers ws

    clients = []
    if ws != nil
      # Get the column number of the users email
      email_user_column = 1
      for col in 2..ws.num_cols do
        if ws[1,col].include? "email"
          email_user_column = col
          break
        end
      end

      if email_user_column > 1
        for row in 2..ws.num_rows
          user_email = ws[row, email_user_column]
          user = User.find_by_email(user_email)
          if user != nil
            client_name = user.client.name
            if !clients.include? client_name
              clients += [client_name]
            end
          end
        end
      end
    end
    clients.sort!
  end

  # Returns the data of the client, such as total answers, users that answered and did not
  def get_data (client_name, session)
    # First worksheet
    ws = session.spreadsheet_by_title(self.name).worksheets[0]

    users_client = User.find_all_by_client_id(Client.find_by_name(client_name).id)
    users_full_names = users_client.map {|uc| uc.full_name}
    data = {:tot_answ => 0, :users => [], :missing_users => users_full_names}
    if ws != nil
      # Get the column number of the users email
      email_user_column = 1
      for col in 2..ws.num_cols do
        if ws[1,col].include? "email"
          email_user_column = col
          break
        end
      end

      if email_user_column > 1
        for row in 2..ws.num_rows
          user_email = ws[row, email_user_column]
          user = User.find_by_email(user_email)
          if user != nil
            if client_name == user.client.name
              data[:tot_answ] += 1
              user_name = user.full_name
              data[:users] += [user_name] if !data[:users].include? user_name
              data[:missing_users].delete(user_name)
            end
          end
        end
      end
    end
    data[:users].sort!
    data[:missing_users].sort!
    users = ""
    data[:users].each do |user|
      if users == ""
        users += user
      else
        users += ", #{user}"
      end
    end
    data[:users] = users
    missing_users = ""
    data[:missing_users].each do |mu|
      if missing_users == ""
        missing_users += mu
      else
        missing_users += ", #{mu}"
      end
    end
    data[:missing_users] = missing_users
    data
  end



  # Returns all the graphics with all the data (answers) of the form\
  # that the client with client_name answered
  def get_full_data (client_name, session)
    graphs = Array.new()
    users_client = User.find_all_by_client_id(Client.find_by_name(client_name).id)
    users_emails = users_client.map {|uc| uc.email}

    # First worksheet
    ws = session.spreadsheet_by_title(self.name).worksheets[0]

    if ws != nil

      # Get the column number of the users email
      col_email_user = 1
      for col in 2..ws.num_cols do
        if ws[1,col].include? "email"
          col_email_user = col
          break
        end
      end

      possible_answers = {:first => ["Bad", "Fair", "Good", "Very Good", "Excellent"], :sec => ["1","2","3","4","5"], :third => ["Email","Landline","Cell","Ticket Management", "Skype or Chat", "Hangout", "Other"]}

      for col in 2..ws.num_cols do
        question = ws[1,col]
        data = nil
        axis_answers = nil
        if ws[2,col].start_with?("Ex","Ver","Goo","Fai","Bad")
          axis_answers = possible_answers[:first]
          data = Array.new(5)
        elsif ws[2,col].start_with?("1","2","3","4","5")
          axis_answers = possible_answers[:sec]
          data = Array.new(5)
        elsif ws[2,col].start_with?("Email","Landline","Cell","Ticket Management", "Skype or Chat", "Hangout")
          axis_answers = possible_answers[:third]
          data = Array.new(7)
        end
        if (data != nil)
          data.map! {0}
          count = 0
          for row in 2..ws.num_rows do
            # The answer is from the client
            user_email = ws[row,col_email_user]
            if users_emails.include? user_email
              pos = 0
              found = false
              axis_answers.each do |answ|
                if ws[row,col].include? answ
                  data[pos] = data[pos] + 1
                  count = count + 1
                  found = true
                end
                pos = pos + 1
              end
              # Case Other in answers type 3
              if axis_answers.first == "Email" && !found
                data[6] += 1
              end
            end
          end

          max = data.max
          if max > 0
            axis_values = Array.new(max)
            for i in 0..max
              axis_values[i] = i
            end
            percent = Array.new(data.count)
            pos = -1
            percent.map! do
              pos = pos + 1
              percent[pos] = (100.0 * data[pos] / count).round
            end
            # Vertical bars graphic
            data.map! {|d| [d]}
            if axis_answers.first == "1"
              graph = Gchart.bar(:size => '500x250', :bar_colors => ['FF0000','FFA000','FFFF00','00FFA0','00FF00'], :legend => ["1 - Strongly disagree  #{percent[0]}%","2 -\t\t #{percent[1]}%","3 -\t\t #{percent[2]}%","4 -\t\t #{percent[3]}%","5 - Strongly agree - #{percent[4]}%"],
                                 :data => data, :axis_with_labels => ['y'], :axis_labels => [axis_values], :stacked => false,  :bar_width_and_spacing => '30,15')
              graphs += [{:title => question, :graph => graph}]
            else # Horizontal bars
              size = axis_answers.first == "Bad" ? "500x160" : "500x225"
              pos = -1
              legend = axis_answers.map do |a|
                pos += 1
                a + " -\t\t #{percent[pos]}%"
              end
              graph = Gchart.bar(:size => size, :orientation => 'horizontal', :bar_colors => ['FF0000','FFA000','FFFF00','00FFA0','00FF00','00FFFF','FF00FF'], :legend => legend,
                                 :data => data, :axis_with_labels => ['x'], :axis_labels => [axis_values], :stacked => false)
              graphs += [{:title => question, :graph => graph}]
            end
          end
        end
      end
    end
    graphs.sort_by {|g| g[:title][/\d+/].to_i}
  end


end
