class AdminController < ApplicationController

  def index

    @graph = {bar:nil, pie:nil}

    data = Array.new(12)
    data.map! {|d| d = 0}
    axis = Array.new(12)

    fechaInicial = Time.now - 1.year + 1.month
    fecha = fechaInicial
    for i in 0..11
      axis[i] = fecha.strftime("%b")
      fecha = fecha + 1.month
    end

    cont = Array.new(12)
    cont.map! {|c| c = 0}
    moods = Mood.all.select { |mood| mood.created_at <= fecha && mood.created_at >= fechaInicial }

    moods.each do |mood|
      mes = mood.created_at.month - 1
      data[mes] += mood.status
      cont[mes] += 1
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
      mood_lvl = mood.status % 2 == 0 ? (mood.status / 2) - 1 : (mood.status - 1) / 2
      data[mood_lvl] += 1
    end

    total = Project.count
    labels = data.map do |numero|
      "(#{total == 0 ? 0 : (100.0 * numero / total).round}%)"
    end
    @graph[:pie] = Gchart.pie_3d(:labels => labels, :data => data, :size => '550x250',
                                   :bar_colors => ['FF0000','FFA000','FFFF00','00FFA0','00FF00'],
                                   :legend => ["1,2","3,4","5,6","7,8","9,10"])

  end


end
