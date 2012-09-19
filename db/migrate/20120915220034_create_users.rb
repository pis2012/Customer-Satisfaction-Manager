class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.integer  :id, :null => false
      t.string   :username, :null => false
      t.string   :full_name, :null => false
      t.string   :email, :null => false
      t.integer  :project_id
      t.integer  :client_id
      t.integer  :role_id, :null => false

      ## OpenID
      t.string   :encrypted_password, :null => false, :default => ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end
    add_foreign_key(:users, :projects)
    add_foreign_key(:users, :clients)
    add_foreign_key(:users, :roles)
    add_index :users, :client_id
  end
end

