require 'spec_helper'

describe ClientsController do

  it "def index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  it "def create" do
    name = 'client1'

    post :create, client: {name:name}

    path = clients_path(assigns[:client]).gsub(".", "/")
    response.should redirect_to(path)

    findByName = Client.find_all_by_name(name)

    findByName.size.should eq(1)
    findByName[0].name.should eq(name)
  end

  it "def create duplicate" do
    name = 'client jadoekn'

    post :create, client: {name:name}
    path = clients_path(assigns[:client]).gsub(".", "/")
    response.should redirect_to(path)

    post :create, client: {name:name}
    assert_response :success
  end

  it "def show" do
    client1=Client.create(name: "Client")

    get :show, id: client1.id

    assert_response :success

    client2 = assigns[:client]

    client1.name.should eq(client2.name)

  end


  it "def destroy" do
    name = 'client1'

    client1=Client.create(name: name)

    delete :destroy, id: client1.to_param

    response.should redirect_to(clients_path)

    Client.find_all_by_name(name).size.should eq(0)
  end

  it "def update" do
    client1=Client.create(name: "Client 1")

    put :update, id: client1.id, client: {name:'Client 2'}

    path = clients_path(assigns[:client]).gsub(".", "/")
    response.should redirect_to(path)
  end
end
