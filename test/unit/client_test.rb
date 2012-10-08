require 'test_helper'

class ClientTest < ActiveSupport::TestCase
   test "ensure_not_referenced_by_any_project" do
     client = Client.new
     assert client.ensure_not_referenced_by_any_project
   end

   test "ensure_not_referenced_by_any_user" do
     client = Client.new
     assert client.ensure_not_referenced_by_any_user
   end
end
