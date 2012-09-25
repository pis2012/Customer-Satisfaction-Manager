require 'spec_helper'

class ClientSpec
  describe Client do
    it "Crea un nuevo cliente" do
      client = Client.new
      client.name = "admin"
      client.name.should eq("admin")
    end
  end
end