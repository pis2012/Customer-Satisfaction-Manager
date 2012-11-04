class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.references :role
      t.references :client

      t.string   :username
      t.string   :full_name
      t.string   :email
      t.string   :openidemail

      ## OpenID
      t.string   :encrypted_password, :default => ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      t.boolean  :disable,  :default => false

      t.timestamps
    end
    add_index :users, :client_id
    add_index  :users, :confirmation_token, :unique => true
  end
end

