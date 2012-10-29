class Project < ActiveRecord::Base
  default_scope :order => 'name'

  belongs_to :client
  has_many :profiles
  has_many :milestones
  has_many :moods
  has_many :feedbacks

  attr_accessible :client, :milestones, :moods, :feedbacks,
                  :description, :end_date, :id, :name, :finalized

  validates :name, :description, :end_date, :presence  => true
  validates_inclusion_of :finalized, :in => [true, false]

  #validates :finalized, :inclusion => {:in => [true, false]}

  def self.get_graph
    data = [0,0,0,0,0]
    Project.all.each do |proj|
      mood = proj.moods.order(:created_at).last
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

end
