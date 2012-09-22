class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.references :role
      t.references :client

      t.string   :username
      t.string   :full_name
      t.string   :email

      ## OpenID
      t.string   :encrypted_password, :default => ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end
    add_index :users, :client_id
  end
end

