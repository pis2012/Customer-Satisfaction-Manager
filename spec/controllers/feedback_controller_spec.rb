require 'spec_helper'

class ProjectControllerSpec

  describe FeedbacksController do


    it "def index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:feedbacks)
    end

    it "def new" do

      type_skype = FeedbackType.create(name:'Skype')
      rol_admin = Role.create(name:'Admin'),
      client1 = Client.create(name:'MicroHard'),
      admin_usr = User.create(role: rol_admin, client: client1,
                              username: 'admin',password:'admin',password_confirmation:'admin',
                              full_name:'Martin Cabrera', email:'cabrera@1234.com')

      project = Project.create({name:'Proyecto',
                              description:'Descripcion de proyecto',
                              end_date:'2013-01-01 00:00:00',
                              finalized:false})

      post :create, feedback: {project_id: project.id,
                               feedback_type_id: type_skype.id,
                               contenido: "hola daniel"}


      response.should redirect_to("/my_projects")
    end


  end
end
