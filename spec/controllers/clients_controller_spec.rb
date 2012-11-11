require 'spec_helper'

class ClientControllerSpec
  describe ClientsController, :type => :controller do

    before :all do
      User.delete_all
      Role.delete_all
      Client.delete_all
      @valid_attributes =
          {
              :usr => User.new(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                  username: 'admin4',password:'admin',password_confirmation:'admin',
                                  full_name:'Martin Cabrera', email:'ca5brera@1234.com')
          }

      @valid_attributes[:usr].skip_confirmation!
      @valid_attributes[:usr].save :validate => false
    end


    it "def index" do
      user = @valid_attributes[:usr]
      sign_in user
      get :index, format:'json'

      assert_response :success
      assert_not_nil assigns(:clients)
      sign_out user
    end

    it "def create" do
      name = 'client1'

      user = @valid_attributes[:usr]
      sign_in user

      post :create, client: {name:name} , format: "js"

      path = clients_path(assigns[:client]).gsub(".", "/")
      assert_response :success

      findByName = Client.find_all_by_name(name)

      findByName.size.should eq(1)
      findByName[0].name.should eq(name)
      sign_out user
    end

    it "def create duplicate" do
      name = 'client jadoekn'

      user = @valid_attributes[:usr]
      sign_in user
      post :create, client: {name:name}     , format: "js"
      path = clients_path(assigns[:client]).gsub(".", "/")
      assert_response :success

      post :create, client: {name:name}   , format: "js"
      assert_response :success
      sign_out user
    end

    it "def show" do
      client1=Client.create(name: "Client")
      user = @valid_attributes[:usr]
      sign_in user
      get :show, id: client1.id, format: "json"
      sign_out user
      assert_response :success

      client2 = assigns[:client]

      client1.name.should eq(client2.name)

    end


    it "def destroy" do
      name = 'client1'

      client1=Client.create(name: name)

      user = @valid_attributes[:usr]
      sign_in user
      delete :destroy, id: client1.id, format: "js"

      assert_response :success

      Client.find_all_by_name(name).size.should eq(0)
      sign_out user
    end

    it "def update" do
      client1=Client.create(name: "Client 1")
      user = @valid_attributes[:usr]
      sign_in user
      put :update, id: client1.id, client: {name:'Client 2'}      , format: "js"
      sign_out user
      path = clients_path(assigns[:client]).gsub(".", "/")
      assert_response :success
    end
  end
end