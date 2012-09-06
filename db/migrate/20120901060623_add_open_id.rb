class AddOpenId < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.openid_authenticatable
    end
  end
end
