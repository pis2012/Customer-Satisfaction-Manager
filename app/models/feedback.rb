class Feedback < ActiveRecord::Base
  belongs_to :feedback_type
  accepts_nested_attributes_for :feedback_type
  belongs_to :project
  belongs_to :user
  has_many :comentarios


  attr_accessible :project, :user, :feedback_type, :asunto,  :contenido ,:created_at, :VisibilidadCliente,:VisibilidadEmpleado,:feedback_type_id , :project_id,:comentario_id

  validates :asunto,   :presence  => true
  validates :contenido ,:presence  => true
  validates :feedback_type_id,:presence  => true

end
