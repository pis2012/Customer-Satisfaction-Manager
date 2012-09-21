class Feedback < ActiveRecord::Base

  # Enumerado para visibility
  PRIVADO = 1
  CONFIDENCIAL = 2
  PUBLICO = 3

  # Enumerado para type
  SKYPE = 4
  EMAIL = 5
  SIMPLE = 6
  RECONOCIMIENTO = 7

  # feeling : -1 .. 1
  attr_accessible :author_id, :content, :feeling, :project_id, :subject, :type, :visibility

  belongs_to :project
  belongs_to :user


end
