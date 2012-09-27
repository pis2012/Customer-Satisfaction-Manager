class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.string :Fecha
      t.string :Contenido

      t.timestamps
    end
  end
end
