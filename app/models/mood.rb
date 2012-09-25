class Mood < ActiveRecord::Base

  belongs_to :project


  attr_accessible :project,
                  :created_at,  :status

  validates :status, :presence  => true
  validates :status, :numericality => {:greater_than_or_equal_to => 1}
  validates :status, :numericality => {:less_than_or_equal_to => 10}

  def get_mood_img p_status

    if p_status == 1 || p_status == 2
      return 'status/1.png'
    elsif p_status == 3 || p_status == 4
      return 'status/3.png'
    elsif p_status == 5 || p_status == 6
      return 'status/5.png'
    elsif p_status == 7 || p_status == 8
      return 'status/7.png'
    else
      return 'status/9.png'
    end

  end

end
