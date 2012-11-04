require 'spec_helper'

class UsersControllerSpec

  describe UsersController, :type => :controller do

    before :all do
      User.delete_all
      Client.delete_all
      Role.delete_all
      Project.delete_all
      client = Client.create(name:'MicroHard')
      @valid_attributes =
          {
              :usr => User.new(role: Role.create(name:'Admin'), client: client,
                               username: 'admin4',password:'admin',password_confirmation:'admin',
                               full_name:'Martin Cabrera', email:'ca5brera@1234.com'),
              :userData =>   {role: Role.create(name:'Client'), client: client,
                              username: 'cli',password:'cli',password_confirmation:'cli',
                              full_name:'cli Cabrera', email:'cli@1234.com'}
          }

      @valid_attributes[:usr].skip_confirmation!
      @valid_attributes[:profile] = Profile.create(user: @valid_attributes[:usr], project:@valid_attributes[:project2], skype_usr:'martin.skype')
      @valid_attributes[:usr].profile = @valid_attributes[:profile]
      @valid_attributes[:usr].save :validate => false
    end

    it "index" do
      user = @valid_attributes[:usr]
      sign_in user

      get :index, format: "json"

      assert_response :success
      sign_out user
    end

    it "show" do
      user = @valid_attributes[:usr]
      sign_in user

      get :show, format: "json", id: user.id

      assert_response :success
      sign_out user
    end

    it "new" do
      user = @valid_attributes[:usr]
      sign_in user

      get :new, format: "json"

      assert_response :success
      sign_out user
    end

    it "edit" do
      user = @valid_attributes[:usr]
      sign_in user

      get :show, format: "json", id: user.id

      assert_response :success
      sign_out user
    end

    it "create" do
      user = @valid_attributes[:usr]
      sign_in user

      put :create, format: "js", user: @valid_attributes[:userData]

      assert_response :success
      sign_out user
    end



    it "destroy" do
      user = @valid_attributes[:usr]
      sign_in user

      delete :destroy, format: "js", id: user.id

      assert_response :success
      sign_out user
    end

    it "name_filter" do
      user = @valid_attributes[:usr]
      sign_in user

      get :name_filter, format: "js", name: "name"

      assert_response :success
      sign_out user
    end

  end
end
