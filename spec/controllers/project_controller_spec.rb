require 'spec_helper'

class ProjectControllerSpec

  describe ProjectsController do

    it "def index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:projects)
    end

    it "def new" do
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

  end
end
