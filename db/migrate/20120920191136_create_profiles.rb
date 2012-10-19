class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.references :user
      t.references :project

      t.boolean  :feedbacks_notifications, :default => false
      t.boolean  :comments_notifications,  :default => false

      t.string :skype_usr
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
