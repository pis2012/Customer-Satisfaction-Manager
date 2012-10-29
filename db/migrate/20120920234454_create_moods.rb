class CreateMoods < ActiveRecord::Migration
  def change
    create_table :faces do |t|

      t.references :project

      t.integer :status

      t.timestamps
    end
  end
end
