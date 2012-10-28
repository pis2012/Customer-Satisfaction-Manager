class Milestone < ActiveRecord::Base
  default_scope :order => 'target_date desc'

  belongs_to :project

  attr_accessible :project, :name, :project_id, :target_date

  validates :name, :target_date, :presence  => true

end
