class CreateClientsFormsJoinTable < ActiveRecord::Migration
  def change
    create_table :clients_forms, :id => false do |t|
      t.integer :client_id
      t.integer :form_id
    end
  end
end
