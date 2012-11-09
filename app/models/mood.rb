  class Mood < ActiveRecord::Base
  default_scope :order => 'created_at desc'

  belongs_to :project

  attr_accessible :project,
                  :created_at, :project_id, :status

  validates :status, :presence  => true
  validates :status, :numericality => {:greater_than_or_equal_to => 1}
  validates :status, :numericality => {:less_than_or_equal_to => 5}

  def get_mood_img
    self.status.to_s + ".png"
  end

  def self.get_graph
    # init of data and axis, used to create the chart
    data = Array.new(12)
    data.map! {0}
    axis = Array.new(12)

    # the data gathered is from the last 12 months
    initial_date = Time.now - 1.year + 1.month
    date = initial_date
    (0..11).each do |i|
      axis[i] = date.strftime("%b")
      date = date + 1.month
    end

    # Is used to count the amount of moods in each month
    cont = Array.new(12)
    cont.map! {0}
    # Only moods from last 12 months
    moods = Mood.where("created_at <= ? && created_at >= ?", date, initial_date)

    # Gathers the data for each mood in it's corresponding month
    moods.each do |mood|
      month = mood.created_at.month - 1
      data[month] += mood.status
      cont[month] += 1
    end

    # cont is used for calculate the average in each month
    cont.map! do |c|
      c == 0 ? 1 : c
    end

    # average of each month in data
    pos = -1
    data.map! do |d|
      pos += 1
      d == 0 ? data[pos-1] : d / cont[pos]
    end

    Gchart.bar(:size => '560x300', :bg => {:color => '76A4FB,1,ffffff,0', :type => 'gradient', :angle => 90},
               :bar_width_and_spacing => '30,15', :bar_colors => 'FF0000',
               :data => data, :axis_with_labels => %w(x y), :axis_labels => [axis,[1,2,3,4,5]])
  end


  def self.get_mood_in_last_days(days)
    Mood.where("created_at >= :start_date",{start_date: Time.now.advance(days: -days)})
  end

end
