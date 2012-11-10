class Project < ActiveRecord::Base
  default_scope :order => 'name'
  scope :related_projects, lambda { |text| where("name LIKE '%' :tag '%' or description LIKE '%' :tag '%'", {:tag => text}) }
  scope :latest_related_projects, lambda { |text,limit| related_projects(text).limit(limit) }


  belongs_to :client
  accepts_nested_attributes_for :client
  has_many :profiles
  has_many :milestones, :dependent => :delete_all
  has_many :moods, :dependent => :delete_all
  belongs_to :mood
  has_many :feedbacks

  before_destroy :ensure_not_ref_by_any_profile
  before_destroy :ensure_not_ref_by_any_feedback

  attr_accessible :client, :milestones, :moods, :mood, :feedbacks, :profiles,
                  :description, :end_date, :id, :name, :finalized, :last_reminder_email_sent, :client_id

  validates :name, :description, :end_date, :presence  => true
  validates_inclusion_of :finalized, :in => [true, false]

  def ensure_not_ref_by_any_profile
    if profiles.count.zero?
      true
    else
      errors[:base] << I18n.t("project.Profiles_present")
      false
    end
  end

  def ensure_not_ref_by_any_feedback
    if feedbacks.count.zero?
      true
    else
      errors[:base] << I18n.t("project.Feedbacks_present")
      false
    end
  end


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
    hours      = difference % 24
    difference = (difference - hours)   / 24
    days       =  difference

    [days,hours]
  end

  def get_next_milestones
    res = [nil,nil]
    unless self.finalized
      current_date = Time.now.to_datetime
      miles = self.milestones.select {|mile| mile.target_date.to_datetime > current_date && mile.target_date.to_datetime < self.end_date.to_datetime}
      miles.sort_by! {|m| m[:target_date]}
      if miles.count > 0
        td = miles.first.target_date.to_datetime
        distance = self.distance_between(current_date,td)
        # Adjustments with the local time offset
        offset = -(current_date.offset * 24).round
        days =  distance[0]
        if distance[1] + offset > 23
          days += 1
        end
        hours = (distance[1] + offset) % 24

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
    Project.where("finalized = 0 and id not in (:projects)",{projects: lastMoods.group_by {|i| i.project_id}.keys})
  end

  def last_feedback
    self.feedbacks.first
  end

  # This cannot be turned into scope. It's an opened issue in rails repository
  def self.recent_projects(date)
    Project.unscoped.where('created_at >= ?', date).order('created_at desc')
  end

  def self.latest_recent_projects(date,limit)
    Project.unscoped.where('created_at >= ?', date).order('created_at desc').limit(limit)
  end

end
