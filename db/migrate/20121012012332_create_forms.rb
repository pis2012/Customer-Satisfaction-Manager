class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.references :user

      t.string :name
      t.string :email
      t.text :wise_token, :default => ""
      t.text :writely_token, :default =>""

      t.timestamps
    end
  end
end
