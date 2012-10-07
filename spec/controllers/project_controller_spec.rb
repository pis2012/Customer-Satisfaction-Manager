require 'spec_helper'

class ProjectControllerSpec

  describe ProjectsController, :type => :controller do

    it "def index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:projects)
    end

    it "def create" do
      post :create, project: {name:'Proyecto',
                                description:'Descripcion de proyecto',
                                end_date:'2013-01-01 00:00:00',
                                finalized:false}

      @var1 = projects_path(assigns[:project])
      @var2 = @var1.gsub(".", "/")
      response.should redirect_to(@var2)
    end

    it "def show" do
      @project1=Project.create(name: "Projecto test",
                               description: "projecto test",
                               end_date:'2013-01-01 00:00:00',
                               finalized: false)

      get :show, id: @project1.to_param

      assert_response :success
    end


    it "def destroy" do
      project1=Project.create(name: "Projecto test2",
                               description: "projecto test",
                               end_date:'2013-01-01 00:00:00',
                               finalized: false)

      delete :destroy, id: project1.to_param

      response.should redirect_to(projects_path)
    end

    it "def update" do
      project1=Project.create(name: "Projecto test2",
                              description: "projecto test",
                              end_date:'2013-01-01 00:00:00',
                              finalized: false)

      put :update, id: project1.id, project: {name:'Proyecto 235',
                                                     description:'Descripcion de proyecto 435'}

      @var1 = projects_path(assigns[:project])
      @var2 = @var1.gsub(".", "/")
      response.should redirect_to(@var2)
    end

    it "show_project_complete" do

      client1 = Client.create(name:'MicroHard2')

      project2 = Project.create(client: client1,
                                name:'Proyecto2',
                                description:'proyecto de verificadores',
                                end_date:'2013-01-01 00:00:00',
                                finalized:false)

      #Se deberá testear que un usurario debe contener un rol.
      rol_simple = Role.create(name:'simple')

      user = User.create(role: rol_simple, client: client1,
                              username: 'user1',password:'user1',password_confirmation:'user1',
                              full_name:'Martin Cabrera', email:'cabrera2@1234.com')

      profile1 = Profile.create(user: user, project:project2,
                                last_login_date:'2012-01-01 00:00:00', skype_usr:'martin.skype')

      user.profile=profile1

      project2.milestones.create(:target_date => '2015-01-01 00:00:00', :project => project2, :name => "Prueba1")

    sign_in user
    get :show_project_complete

    sign_out user

    end


    it "change_profile_project" do
      client1 = Client.create(name:'MicroHard2')

      project2 = Project.create(client: client1,
                                name:'Proyecto2',
                                description:'proyecto de verificadores',
                                end_date:'2013-01-01 00:00:00',
                                finalized:false)

      #Se deberá testear que un usurario debe contener un rol.
      rol_simple = Role.create(name:'simple')

      user = User.create(role: rol_simple, client: client1,
                         username: 'user1',password:'user1',password_confirmation:'user1',
                         full_name:'Martin Cabrera', email:'cabrera2@1234.com')

      profile1 = Profile.create(user: user, project:project2,
                                last_login_date:'2012-01-01 00:00:00', skype_usr:'martin.skype')

      user.profile=profile1

      sign_in user
      post :change_profile_project, id: project2.id

      sign_out user

    end

    it "change_mood" do
      client1 = Client.create(name:'MicroHard2')

      project2 = Project.create(client: client1,
                                name:'Proyecto2',
                                description:'proyecto de verificadores',
                                end_date:'2013-01-01 00:00:00',
                                finalized:false)

      #Se deberá testear que un usurario debe contener un rol.
      rol_simple = Role.create(name:'simple')

      user = User.create(role: rol_simple, client: client1,
                         username: 'user1',password:'user1',password_confirmation:'user1',
                         full_name:'Martin Cabrera', email:'cabrera2@1234.com')

      profile1 = Profile.create(user: user, project:project2,
                                last_login_date:'2012-01-01 00:00:00', skype_usr:'martin.skype')

      user.profile=profile1

      sign_in user
      post :change_profile_project, id: project2.id
      post :change_mood, new_status: 10
      sign_out user
    end

  end
end
