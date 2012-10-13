require 'spec_helper'

class FormControllerSpec
  describe FormsController, :type => :controller do

    it "def new" do
      get :new
      assert_response :success
    end

    it "def new" do
      user = User.create(role:  Role.create(name:'simple'), client: Client.create(name:'MicroHard2'),
                           username: 'user1',password:'user1',password_confirmation:'user1',
                           full_name:'Martin Cabrera', email:'cabrera2@1234.com')

      sign_in user
      post :create, :name=>"name", :email=>"emaill@aserv.com", :password=>"lespass", :user_id=> user.id
      assert_response :success
      sign_out user
    end
  end
end