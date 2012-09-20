






class Feedback < ActiveRecord::Base
  #constants
  Email = 1
  Skype = 2
  Simple = 3
  Formulario = 4
  Reconocimieto = 5



  belongs_to :project
  has_many :comentarios

  attr_accessible :Asunto, :Contenido, :Fecha, :created_at, :VisibilidadEmpleado,:VisibilidadCliente, :tipoFeedback


end
