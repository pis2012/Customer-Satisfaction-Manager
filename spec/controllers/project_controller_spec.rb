require 'spec_helper'

class ProjectControlerSpec
  describe ProjectsController do
    it "def index" do
        get :index,
        assert_response :success
        assert_not_nil assigns(:projects)
    end

    it "def new & show" do
      post :create, format: 'json', project: {name:'Proyecto',
                                description:'Descripcion de proyecto',
                                end_date:'2013-01-01 00:00:00',
                                finalized:false}

      assert_not_nil assigns(:project)

      get :show, id: @controller.instance_variable_get(:project)
      assert_response :success
      assert_not_nil assigns(:project)
    end
  end
end
