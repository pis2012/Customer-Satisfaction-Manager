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
    graphs = []
    client_name = Client.find(client_id).name

    # Logs in
    session = GoogleDrive.login(self.email, self.password)
    # First worksheet
    ws = session.spreadsheet_by_title(self.name).worksheets[0]

    if ws != nil
      # Get the column number of the client(company) name
      colNameClient = 1
      for col in 2..ws.num_cols do
        if ws[1,col].include? "name of your company"
          colNameClient = col
          break
        end
      end

      possible_answers = {:first => Array.new("Bad", "Fair", "Good", "Very Good", "Excellent"), :sec => Array.new("1","2","3","4","5"),
                                              :third => Array.new("Email","Landline","Cell","Ticket Management", "Skype or Chat", "Hangout", "Other")}

      for col in 2..ws.nums_cols do
        question = ws[1,col]
        data = nil
        axis_answers = nil
        if ws[2,col].start_with?("E","V","G","F","B")
          axis_answers = possible_answers(:first)
          data = Array.new(5)
        elsif ws[2,col].start_with?("1","2","3","4","5")
          axis_answers = possible_answers(:sec)
          data = Array.new(5)
        elsif ws[2,col].start_with?("Email","Landline","Cell","Ticket Management", "Skype or Chat", "Hangout")
          axis_answers = possible_answers(:third)
          data = Array.new(7)
        end
        if (data != nil)
          data.map! {0}
          count = 0
          for row in 2..ws.nums_rows do
            # The answer is from the client
            if ws[row,colNameClient].downcase == client_name.downcase
              pos = 0
              axis_answers.each do |answ|
                if answ == ws[row,col]
                  data[pos] = data[pos] + 1
                  count = count + 1
                  break
                end
                pos = pos + 1
              end
              # Case Other in answers type 3
              if axis_answers.first == "Email" && pos == 6
                data[pos] = data[pos] + 1
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
            if axis_answers.first == "1"
              graph = Gchart.bar(:title => question, :bar_colors => 'FF0000', :legend => ["1 - Strongly disagree  #{percent[0]}%","2 -\t\t #{percent[1]}%","3 -\t\t #{percent[2]}%","4 -\t\t #{percent[3]}%","5 - Strongly agree - #{percent[4]}%"],
                                 :data => data, :axis_with_labels => ['x','y'], :axis_labels => [axis_answers,axis_values])
            else # Horizontal bars
              pos = -1
              legend = axis_answers.map do |a|
                pos += 1
                a + " -\t\t #{percent[pos]}%"
              end
              graph = Gchart.bar(:title => question, :orientation => 'horizontal', :bar_colors => 'FF0000', :legend => legend,
                                 :data => data, :axis_with_labels => ['x','y'], :axis_labels => [axis_values,axis_answers])
            end

            # Sort by number at start of the question
            pos = question[0].to_i
            if (pos.class == Fixnum)
              graphs[pos] = graph
            else
              graphs += [graph]
            end
          end
        end
      end
    end
    return graphs
  end




end
