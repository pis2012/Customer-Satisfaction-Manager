require 'spec_helper'

class FeedbacksControllerSpec

  describe FeedbacksController, :type => :controller do

    it "def index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:feedbacks)
    end

    it "def new" do

      @type_skype = FeedbackType.create(name:'Skype2')
      @rol_admin = Role.create(name:'Admin'),
          @client1 = Client.create(name:'MicroHard'),
          @admin_usr = User.create(role: @rol_admin, client: @client1,
                                   username: 'admin',password:'admin',password_confirmation:'admin',
                                   full_name:'Martin Cabrera', email:'cabrera@1234.com')

      @project = Project.create({name:'Proyecto',
                                 description:'Descripcion de proyecto',
                                 end_date:'2013-01-01 00:00:00',
                                 finalized:false})


      contenido =  "hola soy un feedback"

      post :create, project_id: @project.id,feedback: {project: @project, feedback_type_id: @type_skype.id,
                               content: contenido, subject: "mira no soy nil"}


      feedbackCreado = assigns(:feedback);
      response.should redirect_to("/my_projects")

      project = Project.find_by_name("Proyecto")

      feedbacksOfProject = project.feedbacks

      feedbacksOfProject.size.should eq(1)
      feedbacksOfProject[0].contenido.should eq(contenido)
    end


  end
end
