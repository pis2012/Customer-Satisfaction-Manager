require 'spec_helper'

describe ComentariosController do

  it "def index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comentarios)
  end

  it "def create" do
    contenido = 'comentario1'
    fecha = Time.now

    post :create, comentario: {Contenido: contenido, Fecha: fecha}

    path = comentarios_path(assigns[:comentario]).gsub(".", "/")
    response.should redirect_to(path)

    findByName = Comentario.find_all_by_Contenido(contenido)

    findByName.size.should eq(1)
    findByName[0].Contenido.should eq(contenido)
  end

  it "def show" do
    comentario1=Comentario.create(Contenido: "Comentario", Fecha: Time.now)

    get :show, id: comentario1.id

    assert_response :success

    comentario2 = assigns[:comentario]

    comentario1.Contenido.should eq(comentario2.Contenido)

  end


  it "def destroy" do
    contenido = 'comentario1'

    comentario1=Comentario.create(Contenido: contenido, Fecha: Time.now)

    delete :destroy, id: comentario1.id

    response.should redirect_to(comentarios_path)

    Comentario.find_all_by_Contenido(contenido).size.should eq(0)
  end

  it "def update" do
    comentario1=Comentario.create(Contenido: "Comentario 1", Fecha: Time.now)

    put :update, id: comentario1.id, comentario: {Contenido:'Comentario 2'}

    path = comentarios_path(assigns[:comentario]).gsub(".", "/")
    response.should redirect_to(path)
  end
end
