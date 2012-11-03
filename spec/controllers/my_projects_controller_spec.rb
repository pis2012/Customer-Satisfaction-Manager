require 'spec_helper'

describe MyProjectsController do

  before :all do
    User.delete_all

    @valid_attributes =
        {
            :usr => User.create(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                username: 'admin4',password:'admin',password_confirmation:'admin',
                                full_name:'Martin Cabrera', email:'ca5brera@1234.com') ,
            :client => Client.create(name:'MicroHard2')
        }
  end

  it "def index" do
    user = @valid_attributes[:usr]
    client1 = @valid_attributes[:client]
    project2 = Project.create(client: client1,
                              name:'Proyecto2',
                              description:'proyecto de verificadores',
                              end_date:'2013-01-01 00:00:00',
                              finalized:false)
    Mood.create(status: 1, project: project2)
    profile1 = Profile.create(user: user, project:project2, skype_usr:'martin.skype')

    user.profile=profile1

    sign_in user
    get :index, format:'json'

    assert_response :success
    assert_not_nil assigns(:project)
    sign_out user
  end

end
