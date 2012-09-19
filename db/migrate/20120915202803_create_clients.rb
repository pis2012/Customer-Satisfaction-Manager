class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|

      t.integer  :id,   :null => false
      t.string   :name, :null => false

      t.timestamps
    end
  end
end
