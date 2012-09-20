class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :VisibilidadCliente
      t.integer :VisibilidadEmpleado
      t.string :Asunto
      t.date :Fecha
      t.string :Contenido
      t.integer :tipoFeedback

      t.timestamps
    end
  end
end
