class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :project ,:feedback_type ,:user

      t.string :subject
      t.text :content
      t.boolean :client_visibility
      t.boolean :mooveit_visibility

      t.timestamps
    end
  end
end
