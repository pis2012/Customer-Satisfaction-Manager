class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.references :user

      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
