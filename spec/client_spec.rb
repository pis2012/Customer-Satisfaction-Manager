require 'spec_helper'

class Client_spec
  describe Client do
    it "salva el nombre del cliente" do
      client = Client.new
      client.name = "admin"
      client.name.should eq("admin")
    end
  end
end