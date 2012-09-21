class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.references :user
      t.references :project

      t.date :last_login_date
      t.string :image_url
      t.string :skype_usr

      t.timestamps
    end
  end
end
