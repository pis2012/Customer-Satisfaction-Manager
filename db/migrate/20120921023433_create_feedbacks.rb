class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :subject
      t.integer :visibility
      t.string :content
      t.integer :project_id
      t.integer :author_id
      t.integer :type
      t.integer :feeling

      t.timestamps
    end
  end
end
