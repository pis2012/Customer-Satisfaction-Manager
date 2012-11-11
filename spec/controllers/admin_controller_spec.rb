require 'spec_helper'

class AdminControllerSpec
  describe AdminController, :type => :controller do

    before :all do
      User.delete_all
      CsmProperty.delete_all

      @valid_attributes =
          {
              :usr => User.new(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                  username: 'admin4',password:'admin',password_confirmation:'admin',
                                  full_name:'Martin Cabrera', email:'ca5brera@1234.com')  ,
              :prop => CsmProperty.create(name: "name", value: "value")
          }

      @valid_attributes[:usr].skip_confirmation!
      @valid_attributes[:usr].save :validate => false
    end

    it "index" do
      user = @valid_attributes[:usr]
      sign_in user

      get :index, format: "html"

      assert_response :success
      sign_out user
    end

    it "show_reports" do
      user = @valid_attributes[:usr]
      sign_in user

      xhr :get, :show_reports, format: "html"

      assert_response :success
      sign_out user
    end

    it "emails_config" do
      user = @valid_attributes[:usr]
      sign_in user

      xhr :get, :emails_config, format: "html"

      assert_response :success
      sign_out user
    end
  end
end