class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :id, :null => false
      t.string :name, :null => false
      t.string :description, :null => false
      t.datetime :end_date, :null => false
      t.column :status, "ENUM('in_progress', 'finalized')"
      t.integer :client_id, :null => false
      t.timestamps
    end
    add_foreign_key(:projects, :clients)
    add_index :projects, :client_id
  end
end
