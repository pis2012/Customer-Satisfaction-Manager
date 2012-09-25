class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :project ,:feedback_type ,:comentario

      t.string :asunto
      t.text :contenido
      t.date :created_at
      t.boolean :VisibilidadCliente
      t.boolean :VisibilidadEmpleado

      t.timestamps
    end
  end
end
