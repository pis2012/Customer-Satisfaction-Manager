require 'spec_helper'

class ProjectControllerSpec

  describe feedbacksController do



    it "def index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:feedbacks)
    end

    it "def new" do
      post :create, feedback: {name:'Proyecto',
                              description:'Descripcion de proyecto',
                              end_date:'2013-01-01 00:00:00',
                              finalized:false}

      @var1 = feedbacks_path(assigns[:feedback])
      @var2 = @var1.gsub(".", "/")
      response.should redirect_to(@var2)
    end

    it "def show" do
      @feedback1=feedback.create(subject: "Alfonso",
                               content: "This is Sparta",
                               feeling: 1,
                               visibility: true)

      get :show, id: @feedback1.to_param

      assert_response :success
    end
  end
end
