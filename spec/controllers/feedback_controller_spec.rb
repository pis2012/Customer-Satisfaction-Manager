require 'spec_helper'

class ProjectControllerSpec

  describe FeedbacksController do


    it "def index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:feedbacks)
    end

    it "def new" do


      rol_admin = Role.create(name:'Admin'),
      client1 = Client.create(name:'MicroHard'),
      @admin_usr = User.create(role: rol_admin, client: client1,
                              username: 'admin',password:'admin',password_confirmation:'admin',
                              full_name:'Martin Cabrera', email:'cabrera@1234.com')

      post :create, project: {name:'Proyecto',
                              description:'Descripcion de proyecto',
                              end_date:'2013-01-01 00:00:00',
                              finalized:false}



      post :create, feedback: {project: :project,
                               feedback_type: type_skype,
                               contenido: "hola daniel"}

      @var1 = Feedbacks_path(assigns[:feedback])
      @var2 = @var1.gsub(".", "/")
      response.should redirect_to(@var2)
    end


  end
end
