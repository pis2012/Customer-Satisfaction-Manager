require 'spec_helper'

describe MilestonesController, :type => :controller do

  before :all do
    User.delete_all
    Project.delete_all
    Role.delete_all
    Client.delete_all
    @valid_attributes =
        {

            :usr => User.new(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                username: 'admin4',password:'admin',password_confirmation:'admin',
                                full_name:'Martin Cabrera', email:'ca5brera@1234.com')  ,
            :project => Project.create({name:'Proyecto',
                                        description:'Descripcion de proyecto',
                                        end_date:'2013-01-01 00:00:00',
                                        finalized:false}),
            :milestonedata => {:name => "Mile", :project_id => Project.find_by_name("Proyecto").id, :target_date => Time.now  }
        }

    @valid_attributes[:usr].skip_confirmation!
    @valid_attributes[:usr].save :validate => false
  end

  it "def new" do
    user = @valid_attributes[:usr]
    sign_in user
    get :new, project_id:  @valid_attributes[:project].id, format:   'js'

    assert_response :success

    sign_out user
  end

  it "def create" do
    user = @valid_attributes[:usr]
    sign_in user
    post :create, project_id: @valid_attributes[:project].id, milestone:  @valid_attributes[:milestonedata], format: 'js'

    assert_response :success

    sign_out user
  end


  it "def destroy" do
    user = @valid_attributes[:usr]
    sign_in user

    mile = Milestone.create(@valid_attributes[:milestonedata])

    post :destroy, id: mile.id, format: 'js'

    assert_response :success

    sign_out user
  end
end
