require 'spec_helper'

class ProjectControllerSpec

  @type_skype = FeedbackType.create(name:'Skype')
  @rol_admin = Role.create(name:'Admin'),
      @client1 = Client.create(name:'MicroHard'),
      @admin_usr = User.create(role: @rol_admin, client: @client1,
                              username: 'admin',password:'admin',password_confirmation:'admin',
                              full_name:'Martin Cabrera', email:'cabrera@1234.com')

  @project = Project.create({name:'Proyecto',
                            description:'Descripcion de proyecto',
                            end_date:'2013-01-01 00:00:00',
                            finalized:false})


  describe FeedbacksController do

    it "def index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:feedbacks)
    end

    it "def new" do

      contenido =  "hola soy un feedback"

      post :create, feedback: {project_id: @project.id,
                               feedback_type_id: @type_skype.id,
                               contenido: contenido}

      response.should redirect_to("/my_projects")

      project = Project.find(id: @project.id)

      project.get(:feedbacks).

      findByName.size.should eq(1)
      findByName[0].name.should eq(name)

      response.should redirect_to("/my_projects")
    end


  end
end
