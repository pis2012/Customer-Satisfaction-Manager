require 'spec_helper'

class AdminControllerSpec
  describe AdminController, :type => :controller do

    before :all do
      User.delete_all

      @valid_attributes =
          {
              :usr => User.create(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                  username: 'admin4',password:'admin',password_confirmation:'admin',
                                  full_name:'Martin Cabrera', email:'ca5brera@1234.com')
          }
    end

    it "def index" do
      user = @valid_attributes[:usr]
      sign_in user
      get :index
      assert_response :success
      sign_out user
    end
  end
end