class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.date :date_created
      t.integer :status
      t.integer :project_id

      t.timestamps
    end
  end
end
