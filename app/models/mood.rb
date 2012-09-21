class Mood < ActiveRecord::Base
  # Enumerado para status
  CONTENTO = 1
  ENOJADO = 2
  NORMAL = 3

  attr_accessible :date_created, :project_id, :status

  belongs_to :project
end
