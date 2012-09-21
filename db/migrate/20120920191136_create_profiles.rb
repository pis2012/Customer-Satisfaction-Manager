class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.date :last_login_date
      t.integer :project_id

      t.timestamps
    end
  end
end
