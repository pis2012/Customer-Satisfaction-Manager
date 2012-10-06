class Mood < ActiveRecord::Base

  belongs_to :project

  attr_accessible :project,
                  :created_at, :project_id, :status

  validates :status, :presence  => true
  validates :status, :numericality => {:greater_than_or_equal_to => 1}
  validates :status, :numericality => {:less_than_or_equal_to => 10}

  def get_mood_img
    mood_lvl = self.status % 2 == 0 ? self.status-1 : self.status
    mood_lvl.to_s + ".png"
  end

end
