require 'spec_helper'

class AdminControllerSpec
describe AdminController, :type => :controller do

  it "def index" do
    get :index
    assert_response :success
  end
end
end