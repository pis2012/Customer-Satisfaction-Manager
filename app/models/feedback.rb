class Feedback < ActiveRecord::Base
  belongs_to :feedback_type

  belongs_to :project
  belongs_to :user
  has_many :comentarios


  attr_accessible :asunto,  :contenido ,:created_at, :VisibilidadCliente,:VisibilidadEmpleado,:feedback_type_id , :project_id,:comentario_id

  validate :asunto,  :contenido , :feedback_type_id, :presence  => true

end
