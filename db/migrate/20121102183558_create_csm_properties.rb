class CreateCsmProperties < ActiveRecord::Migration
  def change
    create_table :csm_properties do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
