require 'spec_helper'

describe FormsController, :type => :controller do

  before :all do
    User.delete_all
    Client.delete_all
    Role.delete_all
    Client.delete_all
    @valid_attributes =
        {
            :usr => User.new(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                             username: 'admin4',password:'admin',password_confirmation:'admin',
                             full_name:'Martin Cabrera', email:'cabrera@1234.com') ,
            :client => Client.create(name:'MicroHard2') ,
            :form => {
                :email => 'pis2012gr1@gmail.com',
                :password => 'pis2012gr1pass',
                :name => 'CSM'
            },
            :form2 => {
                :email => 'pis2012gr1@gmail.com',
                :name => 'CSM'
            }
        }

    @valid_attributes[:project2]  =    Project.create(client: @valid_attributes[:client],
                                                      name:'Proyecto2',
                                                      description:'proyecto de verificadores',
                                                      end_date:'2013-01-01 00:00:00',
                                                      finalized:false)
    @valid_attributes[:usr].skip_confirmation!
    @valid_attributes[:profile] = Profile.create(user: @valid_attributes[:usr], project: @valid_attributes[:project2], skype_usr:'martin.skype')
    @valid_attributes[:usr].profile = @valid_attributes[:profile]
    @valid_attributes[:usr].save :validate => false
  end

  it "def index" do
    user = @valid_attributes[:usr]
    sign_in user

    get :index, format:'js'

    assert_response :success
    sign_out user
  end

  it "def new" do
    user = @valid_attributes[:usr]
    sign_in user

    get :new, format:'js'

    assert_response :success
    sign_out user
  end

  it "def create" do
    user = @valid_attributes[:usr]
    sign_in user

    post :create, format:'js', form: @valid_attributes[:form]

    assert_response :success
    sign_out user
  end

  it "def show" do
    user = @valid_attributes[:usr]
    sign_in user

    post :create, format:'html', form: @valid_attributes[:form]
    form = assigns(:form)
    get :show, format:'html', id: form.id

    assert_response :success
    sign_out user
  end

  it "show_data" do
    user = @valid_attributes[:usr]
    sign_in user

    post :create, format:'js', form: @valid_attributes[:form]
    form = assigns(:form)
    get :show_data, format:'js', id: form.id, client_name: 'MicroHard'

    assert_response :success
    sign_out user
  end

  it "show_full_data" do
    user = @valid_attributes[:usr]
    sign_in user

    post :create, format:'js', form: @valid_attributes[:form]
    form = assigns(:form)
    get :show_full_data, format:'js', id: form.id, client_name: 'MicroHard'

    assert_response :success
    sign_out user
  end

  it "destroy" do
    user = @valid_attributes[:usr]
    sign_in user

    post :create, format:'js', form: @valid_attributes[:form]
    form = assigns(:form)
    delete :destroy, format:'js', id: form.id

    assert_response :success
    sign_out user
  end
end
