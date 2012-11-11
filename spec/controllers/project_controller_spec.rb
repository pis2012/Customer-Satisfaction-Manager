require 'spec_helper'

class ProjectControllerSpec

  describe ProjectsController, :type => :controller do

    before :all do
      User.delete_all
      Role.delete_all
      Client.delete_all
      Project.delete_all
      @valid_attributes =
          {
              :usr => User.new(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                  username: 'admin4',password:'admin',password_confirmation:'admin',
                                  full_name:'Martin Cabrera', email:'ca5brera@1234.com') ,
              :client1 => Client.create(name:'MicroHard2') ,
              :rol_simple => Role.create(name:'simple')
          }

      @valid_attributes[:project1] = Project.create(client: @valid_attributes[:client1],
                                                    name:'Proyecto1',
                                                    description:'proyecto de verificadores',
                                                    end_date:'2013-01-01 00:00:00',
                                                    finalized:false)

      @valid_attributes[:project2] = Project.create(client: @valid_attributes[:client1],
                                  name:'Proyecto2',
                                  description:'proyecto de verificadores',
                                  end_date:'2013-01-01 00:00:00',
                                  finalized:false)

      @valid_attributes[:profile1] = Profile.create(user: @valid_attributes[:usr], project:@valid_attributes[:project2], skype_usr:'martin.skype')

      @valid_attributes[:usr].profile = @valid_attributes[:profile1]

      @valid_attributes[:usr].skip_confirmation!
      @valid_attributes[:usr].save :validate => false
    end

    it "def index" do
      user = @valid_attributes[:usr]
      sign_in user
      get :index, format: "json"
      assert_response :success
      assert_not_nil assigns(:projects)

      sign_out user
    end


    it "def destroy" do
      user = @valid_attributes[:usr]
      sign_in user
      project1=Project.create(name: "Projecto test2",
                               description: "projecto test",
                               end_date:'2013-01-01 00:00:00',
                               finalized: false)

      delete :destroy, id: project1.to_param, format: "js"

      assert_response :success
      sign_out user
    end

    it "def update" do
      user = @valid_attributes[:usr]
      sign_in user
      project1=Project.create(name: "Projecto test2",
                              description: "projecto test",
                              end_date:'2013-01-01 00:00:00',
                              finalized: false)

      put :update, id: project1.id,
          project: {name:'Proyecto 235',description:'Descripcion de proyecto 435'},
          format: "js"


      assert_response :success
      sign_out user
    end

    it "change_profile_project" do
      user = @valid_attributes[:usr]
      sign_in user
      post :change_profile_project, project_id: @valid_attributes[:project1].id

      response.should redirect_to(my_projects_url)

      sign_out user

    end

    it "show_project_data" do
      user = @valid_attributes[:usr]
      sign_in user

      get :show_project_data, format: 'json', project_id: @valid_attributes[:project1].id

      assert_response :success
      sign_out user
    end

    it "change_mood" do
      user = @valid_attributes[:usr]
      sign_in user
      post :change_mood, new_status: 5, project_id: @valid_attributes[:project1].id
      sign_out user
    end

    it "edit" do
      user = @valid_attributes[:usr]
      sign_in user
      post :edit, id: @valid_attributes[:project1].id
      sign_out user
    end

    it "new" do
      user = @valid_attributes[:usr]
      sign_in user
      post :new, format: "json"
      sign_out user
    end

    it "text_filter" do
      user = @valid_attributes[:usr]
      sign_in user
      get :text_filter, projects_filter_text: "name", format: "js"
      assert_response :success
      sign_out user
    end

    it "change_any_project_mood" do
      user = @valid_attributes[:usr]
      sign_in user

      post :change_mood, project_id: @valid_attributes[:project1].id, new_status: 5

      assert_response :success
      sign_out user
    end

  end
end
