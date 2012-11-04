require 'spec_helper'

describe MyProjectsController, :type => :controller do


  before :all do
    User.delete_all
    Client.delete_all
    Role.delete_all
    Client.delete_all
    @valid_attributes =
        {
            :usr => User.new(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                username: 'admin4',password:'admin',password_confirmation:'admin',
                                full_name:'Martin Cabrera', email:'ca5brera@1234.com') ,
            :client => Client.create(name:'MicroHard2')
        }

    @valid_attributes[:project2]  =    Project.create(client: @valid_attributes[:client],
                                                      name:'Proyecto2',
                                                      description:'proyecto de verificadores',
                                                      end_date:'2013-01-01 00:00:00',
                                                      finalized:false)
    @valid_attributes[:usr].skip_confirmation!
    @valid_attributes[:profile] = Profile.create(user: @valid_attributes[:usr], project:@valid_attributes[:project2], skype_usr:'martin.skype')
    @valid_attributes[:usr].profile = @valid_attributes[:profile]
    @valid_attributes[:usr].save :validate => false
  end

  it "def index" do
    user = @valid_attributes[:usr]
    Mood.create(status: 1, project: @valid_attributes[:project2])

    sign_in user
    get :index, format:'html'

    assert_response :success
    assert_not_nil assigns(:project)
    sign_out user
  end


end
