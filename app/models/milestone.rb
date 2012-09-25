class Milestone < ActiveRecord::Base

  belongs_to :project

  attr_accessible :project, :name, :project_id, :target_date

  validates :name, :target_date, :presence  => true

end
