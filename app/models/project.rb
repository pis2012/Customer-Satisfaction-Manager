class Project < ActiveRecord::Base
  default_scope :order => 'name'

  belongs_to :client
  has_many :profiles
  has_many :milestones
  has_many :moods
  has_many :feedbacks

  attr_accessible :client, :milestones, :moods, :feedbacks,
                  :description, :end_date, :id, :name, :finalized, :last_reminder_email_sent

  validates :name, :description, :end_date, :presence  => true
  validates_inclusion_of :finalized, :in => [true, false]

  #validates :finalized, :inclusion => {:in => [true, false]}

  def self.get_graph
    data = [0,0,0,0,0]
    Project.all.each do |proj|
      mood = proj.moods.first
      if mood
        data[mood.status-1] += 1
      end
    end

    total = Project.count
    labels = data.map do |number|
      val = total == 0 ? 0 : (100.0 * number / total).round
      "(#{val}%)"
    end
    Gchart.pie_3d(:labels => labels, :data => data, :size => '550x250',
                  :bar_colors => ['FF0000','FFA000','FFFF00','00FFA0','00FF00'],
                  :legend => ["1","2","3","4","5"])
  end

  def get_mood_graph
    data = Array.new
    axis = Array.new
    self.moods.limit(20).each do |mood|
      axis = axis + ["#{mood.created_at.mday}/#{mood.created_at.mon}"]
      data = data + [mood.status]
    end
    axis.reverse!
    data.reverse!
    Gchart.line(:size => '850x350', :bg => {:color => '76A4FB,1,ffffff,0', :type => 'gradient'}, :graph_bg => 'E5E5E5', :theme => :keynote,
                :data => data, :axis_with_labels => ['x','y'], :axis_labels => [axis,[1,2,3,4,5]])
  end

  def distance_between(start_date, end_date)
    difference =  end_date.to_i - start_date.to_i
    seconds    =  difference % 60
    difference = (difference - seconds) / 60
    minutes    =  difference % 60
    difference = (difference - minutes) / 60
    hours      =  (difference + 4) % 24
    difference = (difference + 4 - hours)   / 24
    days       =  difference

    [days,hours]
  end

  def get_next_milestones
    res = [nil,nil]
    if !self.finalized
      current_date = Time.now.to_datetime
      miles = self.milestones.select {|mile| mile.target_date.to_datetime > current_date}
      miles.sort_by! {|m| m[:target_date]}
      if miles.count > 0
        td = miles.first.target_date.to_datetime
        distance = self.distance_between(current_date,td)
        days = distance[0]
        hours = distance[1]

        res[0] = [days,hours,miles.first.name]
        if miles.count > 1
          res[1] = [1,miles.second.target_date]
        else
          res[1] = [2,self.end_date]
        end
      else
        res[0] = self.end_date
      end
    end
    res
  end


  def get_random_user
    self.client.users.sample
  end

  def self.get_projects_with_no_activity(days)
    lastMoods = Mood.get_mood_in_last_days(days)
    projects = Project.where("finalized = 0 and id not in (:projects)",{projects: lastMoods.group_by {|i| i.project_id}.keys})
  end
end
