class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.references :client

      t.string :name
      t.string :email
      t.text :wise_token, :default => ""
      t.text :writely_token, :default =>""
      t.integer :actual_total_answers, :default => 0

      t.timestamps
    end
    add_index :forms, [:name, :email], :unique => true
  end
end
