require 'spec_helper'

class FeedbacksControllerSpec

  describe FeedbacksController, :type => :controller do

    before :all do
      FeedbackType.delete_all
      User.delete_all
      @valid_attributes =
      {
          :contenido => "hola soy un feedback",
          :subject => "mira no soy nil",
          :type_skype => FeedbackType.create(name:'Skype21',image_url:'/assets/feedbacks/generic.png'),
          :usr => User.create(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                              username: 'admin4',password:'admin',password_confirmation:'admin',
                              full_name:'Martin Cabrera', email:'ca5brera@1234.com'),
          :project => Project.create({name:'Proyecto',
                                      description:'Descripcion de proyecto',
                                      end_date:'2013-01-01 00:00:00',
                                      finalized:false})
      }
    end

    after :all do
      FeedbackType.destroy(@valid_attributes[:type_skype])
      User.destroy(@valid_attributes[:usr])
      Project.destroy(@valid_attributes[:project])
    end

    it "def index" do
      get :index, format: "json"
      assert_response :success
      assert_not_nil assigns(:feedbacks)
    end

    it "def create" do
      user = @valid_attributes[:usr]
      sign_in user
      post :create, project_id: @valid_attributes[:project].id,feedback: {project_id: @valid_attributes[:project].id, feedback_type_id: @valid_attributes[:type_skype].id,
                               content: @valid_attributes[:contenido], subject: @valid_attributes[:subject] }




      feedbackCreado = assigns(:feedback);
      response.should redirect_to("/my_projects")

      project = Project.find_by_name("Proyecto")

      feedbacksOfProject = project.feedbacks

      feedbacksOfProject.size.should eq(1)
      feedbacksOfProject[0].content.should eq(@valid_attributes[:contenido])
      sign_out user
    end

    it "def show" do
      feedback = Feedback.create(:project=> @valid_attributes[:project], :user=> @valid_attributes[:usr],
                                 :feedback_type=> @valid_attributes[:type_skype],:project_id=> @valid_attributes[:project].id,:user_id=> @valid_attributes[:usr].id,
                                 :subject=> "subject", :content=> "content",:created_at=> Time.now,
                                 :updated_at=> Time.now, :client_visibility=> false,
                                 :mooveit_visibility => false, :feedback_type_id=> @valid_attributes[:type_skype].id)
      get :show, id: feedback.id, format: "json"

      assert_response :success
    end

    it "def edit" do
      feedback = Feedback.create(:project=>@valid_attributes[:project], :user=> @valid_attributes[:usr], :feedback_type=> @valid_attributes[:type_skype],
                                 :project_id=> @valid_attributes[:project].id,:user_id=> @valid_attributes[:usr].id,
                                 :subject=> "subject", :content=> "content",:created_at=> Time.now,
                                 :updated_at=> Time.now, :client_visibility=> false, :mooveit_visibility => false,:feedback_type_id=> @valid_attributes[:type_skype].id)

      get :edit, id: feedback.id

      assert_response :success
    end

    it "def new" do
      get :new

      assert_response :success
    end

    it "def destroy" do
      feedback = Feedback.create(:project=>@valid_attributes[:project], :user=> @valid_attributes[:usr], :feedback_type=> @valid_attributes[:type_skype],
                                 :project_id=> @valid_attributes[:project].id,:user_id=> @valid_attributes[:usr].id,
                                 :subject=> "subject", :content=> "content",:created_at=> Time.now,
                                 :updated_at=> Time.now, :client_visibility=> false, :mooveit_visibility => false,:feedback_type_id=> @valid_attributes[:type_skype].id)

      delete :destroy, id: feedback.id

      response.should redirect_to(feedbacks_url)
    end

    it "def update" do
      feedback = Feedback.create(:project=>@valid_attributes[:project], :user=> @valid_attributes[:usr], :feedback_type=> @valid_attributes[:type_skype],
                                 :project_id=> @valid_attributes[:project].id,:user_id=> @valid_attributes[:usr].id,
                                 :subject=> "subject", :content=> "content",:created_at=> Time.now,
                                 :updated_at=> Time.now, :client_visibility=> false, :mooveit_visibility => false,:feedback_type_id=> @valid_attributes[:type_skype].id)
      user = @valid_attributes[:usr]
      sign_in user
      put :update, id: feedback.id, :feedback=> {content: "new content"}


      var = feedbacks_url(assigns[:feedback]).gsub(".", "/").gsub("test/host", "test.host")
      response.should redirect_to(var)

      sign_out user
    end
  end
end
