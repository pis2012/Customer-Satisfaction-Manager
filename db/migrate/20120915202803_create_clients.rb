class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :form
      t.string   :name

      t.timestamps
    end
  end
end
