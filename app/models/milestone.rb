class Milestone < ActiveRecord::Base
  attr_accessible :name, :project_id, :target_date

  belongs_to :project

end
