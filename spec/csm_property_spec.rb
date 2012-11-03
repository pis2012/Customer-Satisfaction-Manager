require 'spec_helper'

class CsmPropertySpec
  describe CsmProperty do
    it "get_property" do
      CsmProperty.create(name: "name", value: "value")

      CsmProperty.get_property("name","value2").should eq('value')
    end
  end
end