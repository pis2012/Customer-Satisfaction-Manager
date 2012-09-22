class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|

      t.references :project, :user, :feedback_type

      t.string :subject
      t.boolean :client_visibility
      t.boolean :mooveit_visibility
      t.text :content
      t.integer :feeling

      t.timestamps
    end
  end
end
