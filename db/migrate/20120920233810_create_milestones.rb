class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :name
      t.date :target_date
      t.integer :project_id

      t.timestamps
    end
  end
end
