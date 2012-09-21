class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|

      t.references :project

      t.string :name
      t.date :target_date

      t.timestamps
    end
  end
end
