class Client < ActiveRecord::Base
  self.table_name = "csm_clients"

  #default_scope where("visible = ?", true)

  attr_accessible :date_created, :name, :date_updated
end
