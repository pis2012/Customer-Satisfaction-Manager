class Form < ActiveRecord::Base

  has_and_belongs_to_many :clients
  # :name := Name of the form(spreadsheet) in the google drive account
  # :email := Email corresponding to the google drive account
  # :password := Password corresponding to the google drive account
  attr_accessible :name, :email, :wise_token, :writely_token, :actual_total_answers

  validates :email, :name, :presence => true

  def init (params)
    begin
      session = GoogleDrive.login(params["form"]["email"],params["form"]["password"])
    rescue
      self.errors[:base] << "authentication"
    else
      self.name = params["form"]["name"]
      self.email = params["form"]["email"]
      ws = validates? session
      if ws != nil
        get_clients ws # Update total answers and clients
        return true
      end
    end
    false
  end

  def get_session_worksheet
    session = GoogleDrive.restore_session({:wise => self.wise_token.to_s, :writely => self.writely_token.to_s})
    # First worksheet
    session.spreadsheet_by_title(self.name).worksheets[0]
  end

  # Validates, initializes the form and return the worksheet if is valid, otherwise nil
  def validates? (session)
    auth_tokens = session.auth_tokens()
    self.wise_token = auth_tokens[:wise]
    self.writely_token = auth_tokens[:writely]
    begin
      # First worksheet
      ws = session.spreadsheet_by_title(self.name).worksheets[0]
    rescue
      self.errors[:base] << "not_exists"
      return nil
    end
    is_valid? ws
  end

  private :validates?

  # checks if the form has a email column and that the first
  # column has timestamps
  def is_valid? (ws)
    if ws[1,1].include? "Marca temporal"
      if (get_email_column ws) != 1
        return ws
      end
    end
    nil
  end

  private :is_valid?

  # Get the column number of the users email
  # The form MUST have a question "Please write your email"
  def get_email_column (ws)
    email_user_column = 1
    (2..ws.num_cols).each do |col|
      if ws[1,col].include? "Please write your email"
        email_user_column = col
        break
      end
    end
    email_user_column
  end

  private :get_email_column

  # Updates the total answers in the form
  def update_total_answers (ws)
    self.actual_total_answers = ws.num_rows-1
  end

  private :update_total_answers

  # Updates the clients linked to the form (answered the form)
  def update_clients (clients_names)
    clients_names.each do |client_name|
      client = Client.find_by_name(client_name)
      self.clients << client unless self.clients.exists? client
    end
  end

  private :update_clients

  def get_actual_clients
    clients = []
    self.clients.each do |client|
      clients += [client.name]
    end
    clients.sort!
    join_names(clients)
  end

  # Returns the clients that answered the form
  def get_clients (ws)
    clients = []
    email_user_column = get_email_column ws
    # checks that the email column still exists, the form can be
    # altered in the drive. In the case that the column not exists
    # anymore it returns an empty array of clients, the form is not valid
    if email_user_column > 1
      (2..ws.num_rows).each do |row|
        user_email = ws[row, email_user_column]
        user = User.find_by_email(user_email)
        if user != nil && user.client != nil # Admin case?
          client_name = user.client.name
          clients += [client_name] unless clients.include? client_name
        end
      end
    end

    # update total answers
    update_total_answers ws
    # update clients linked
    update_clients clients

    clients.sort!
  end

  # Join of the names into a single string with ,
  def join_names (names)
    names_res = ""
    names.each do |name|
      names_res += names_res != "" ? ", #{name}" : name
    end
    names_res
  end

  private :join_names

  def get_users_full_names(client_name)
    users_full_names = []
    if client_name == ""
      # Get the full names of all the users from the form's clients
      self.clients.each do |client|
        users_full_names += client.users.map {|uc| uc.full_name}
      end
    else
      # Get the full names of the users with client name == client_name,
      users_client = self.clients.find_by_name(client_name).users
      users_full_names = users_client.map {|uc| uc.full_name}
    end
    users_full_names
  end

  private :get_users_full_names

  # Returns the data of the client, such as total answers, users that answered and did not
  # If client_name is "" then it returns the data of all clients in the form
  def get_data (client_name, ws)
    # First worksheet
    ws ||= self.get_session_worksheet

    # Get the full names of the users with client name == client_name, or
    # if the client_name is "" then get the full names of all users from the form's clients
    users_full_names = get_users_full_names client_name
    data = {:tot_answ => 0, :users => [], :missing_users => users_full_names}

    email_user_column = get_email_column ws
    if email_user_column > 1
      (2..ws.num_rows).each do |row|
        # Find the user with email corresponding to the cell [row,email_user_column] in the form
        user = User.find_by_email(ws[row, email_user_column])
        # If the user not exists in the system then it isn't valid, can't be returned
        if user != nil && user.client != nil
          # Only the rows that correspond to the client with client_name
          if client_name == "" || client_name == user.client.name
            data[:tot_answ] += 1
            user_name = user.full_name
            # Is added only if not is already
            data[:users] += [user_name] unless data[:users].include? user_name
            # Is deleted from the missing users the user_name
            data[:missing_users].delete(user_name)
          end
        end
      end

      data[:users].sort!
      data[:users] = join_names(data[:users])
      data[:missing_users].sort!
      data[:missing_users] = join_names(data[:missing_users])
    end
    data
  end

  def get_users_emails(client_name)
    users_emails = []
    if client_name == ""
      self.clients.each do |client|
        users_emails += client.users.map {|uc| uc.email}
      end
    else
      users_client = self.clients.find_by_name(client_name).users
      users_emails = users_client.map {|uc| uc.email}
    end
    users_emails
  end

  private :get_users_emails

  # Returns all the graphics with all the data (answers) of the form
  # that the client with client_name answered
  # If client_name is "" then it returns the data of all clients in the form
  def get_full_data (client_name, ws)
    # First worksheet
    ws ||= self.get_session_worksheet
    graphs = Array.new()

    # Get the emails of the users with client name == client_name, or
    # if the client_name is "" then get the emails of all users from the form's clients
    users_emails = get_users_emails client_name

    email_user_column = get_email_column ws
    if email_user_column > 1

      # Three possible answers to the questions in the form ...
      possible_answers = {:first => ["Bad", "Fair", "Good", "Very Good", "Excellent"], :sec => %w(1 2 3 4 5), :third => ["Email","Landline","Cell","Ticket Management", "Skype or Chat", "Hangout", "Other"]}

      (2..ws.num_cols).each do |col|
        # The question is in the first row
        question = ws[1,col]
        data = nil
        axis_answers = nil
        # Depending on the first answer it creates the data array and
        # the answers in the axis of the graph generated
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

        # Only if the answers if one of the three possibles
        if data != nil
          data.map! {0}
          # For counting the answers without repeating
          count_answers = 0
          # For counting the total answers by the users from the client
          # to every question
          count = 0
          (2..ws.num_rows).each do |row|
            user_email = ws[row,email_user_column]
            # The answer is by an user from the client/s
            if users_emails.include? user_email
              count_answers += 1
              pos = 0
              # answers type 3
              if axis_answers.first == "Email"
                found = false
                axis_answers.each do |answ|
                  # With this type it can have more than one answer
                  if ws[row,col].include? answ
                    data[pos] += 1
                    count += 1
                    found = true
                  end
                  pos += 1
                end
                # Case Other in answers type 3
                data[6] += 1 unless found
              else
                axis_answers.each do |answ|
                  # Exact answer
                  if ws[row,col] == answ
                    data[pos] += 1
                    count += 1
                    break # Only one answer for this type
                  end
                  pos += 1
                end
              end
            end
          end
          graph = get_graph(data, count_answers, count, axis_answers)
          # Only if graph was generated
          graphs += [{:title => question, :graph => graph}] if graph != nil
        end
      end
    end
    #Sort by the number in beggining of the questions of the form
    graphs.sort_by {|g| g[:title][/\d+/].to_i}
  end

  def get_graph (data, count_answers, count, axis_answers)
    graph = nil

    # If some answer was found then max > 0
    # and the graph is generated
    max = data.max
    if max > 0
      axis_values = Array.new(max)
      (0..max).each do |i|
        axis_values[i] = i
      end

      percent = Array.new(data.count)
      pos = -1
      percent.map! do
        pos += 1
        percent[pos] = ((count * 100.0 / count_answers) * data[pos] / count).round
      end

      # This is made because how Gchart works
      data.map! {|d| [d]}

      # Vertical bars graphic
      if axis_answers.first == "1"
        graph = Gchart.bar(:size => '500x250', :bar_colors => %w(FF0000 FFA000 FFFF00 00FFA0 00FF00),
                           :legend => ["1 - Strongly disagree  #{percent[0]}%","2 -\t\t #{percent[1]}%","3 -\t\t #{percent[2]}%","4 -\t\t #{percent[3]}%","5 - Strongly agree - #{percent[4]}%"],
                           :data => data, :axis_with_labels => %w(y), :axis_labels => [axis_values], :stacked => false,  :bar_width_and_spacing => '30,15')
      # Horizontal bars grapic
      else
        size = axis_answers.first == "Bad" ? "500x160" : "500x225"
        pos = -1
        legend = axis_answers.map do |a|
          pos += 1
          a + " -\t\t #{percent[pos]}%"
        end
        graph = Gchart.bar(:size => size, :orientation => 'horizontal', :bar_colors => %w(FF0000 FFA000 FFFF00 00FFA0 00FF00 00FFFF FF00FF), :legend => legend,
                           :data => data, :axis_with_labels => %w(x), :axis_labels => [axis_values], :stacked => false)
      end
    end
    graph
  end

  private :get_graph

end
