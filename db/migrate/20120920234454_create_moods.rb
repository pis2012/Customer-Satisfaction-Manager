class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|

      t.references :project

      t.integer :status

      t.timestamps
    end
  end
end
