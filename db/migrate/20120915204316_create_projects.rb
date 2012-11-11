class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.references :client, :mood

      t.string :name
      t.text :description
      t.datetime :end_date
      t.boolean :finalized
      t.timestamps
    end
    add_index :projects, :client_id
  end
end
