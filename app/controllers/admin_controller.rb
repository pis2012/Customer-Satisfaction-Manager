class AdminController < ApplicationController

  def index

    @graph = {bar:nil, pie:nil}

    data = Array.new(12)
    data.map! {|d| d = 0}
    axis = Array.new(12)

    initial_date = Time.now - 1.year + 1.month
    date = initial_date
    for i in 0..11
      axis[i] = date.strftime("%b")
      date = date + 1.month
    end

    cont = Array.new(12)
    cont.map! {|c| c = 0}
    moods = Mood.all.select { |mood| mood.created_at <= date && mood.created_at >= initial_date }

    moods.each do |mood|
      month = mood.created_at.month - 1
      data[month] += mood.status
      cont[month] += 1
    end

    cont.map! do |c|
      c = c == 0 ? 1 : c
    end

    pos = -1
    data.map! do |d|
      pos += 1
      d = d == 0 ? data[pos-1] : d / cont[pos]
    end

    @graph[:bar] = Gchart.bar(:size => '560x300', :bg => {:color => '76A4FB,1,ffffff,0', :type => 'gradient', :angle => 90},
                                :bar_width_and_spacing => '30,15', :bar_colors => 'FF0000',
                                :data => data, :axis_with_labels => ['x','y'], :axis_labels => [axis,[1,2,3,4,5,6,7,8,9,10]])


    data = [0,0,0,0,0]
    Project.all.each do |proj|
      mood = proj.moods.order(:created_at).last
      if (mood)
        mood_lvl = mood.status % 2 == 0 ? (mood.status / 2) - 1 : (mood.status - 1) / 2
        data[mood_lvl] += 1
      end
    end

    total = Project.count
    labels = data.map do |number|
      "(#{total == 0 ? 0 : (100.0 * number / total).round}%)"
    end
    @graph[:pie] = Gchart.pie_3d(:labels => labels, :data => data, :size => '550x250',
                                   :bar_colors => ['FF0000','FFA000','FFFF00','00FFA0','00FF00'],
                                   :legend => ["1,2","3,4","5,6","7,8","9,10"])

  end


  def forms
    session = GoogleDrive.login("username@gmail.com", "mypassword")
    ws = session.spreadsheet_by_title("Customer Satisfaction Survey - July 2012").worksheets[0]


  end


end
