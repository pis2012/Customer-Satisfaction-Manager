class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.references :user
      t.references :project

      t.string :skype_usr
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
