class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.references :role
      t.references :client
      t.references :project #esto se va a quitar. El usuario tiene un profile, y el profile tiene un proyecto


      t.string   :username, :null => false
      t.string   :full_name, :null => false
      t.string   :email, :null => false
      t.integer  :project_id
      t.integer  :client_id

      ## OpenID
      t.string   :encrypted_password, :null => false, :default => ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end
    add_index :users, :client_id
  end
end

