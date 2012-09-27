class Comentario < ActiveRecord::Base
  attr_accessible :Contenido, :Fecha

  belongs_to :feedback
end
