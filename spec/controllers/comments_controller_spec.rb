require 'spec_helper'
require 'comments_controller'

describe CommentsController, :type => :controller do

  it "def index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  it "def create" do
    content = 'Comment1'
    created_at = Time.now
    rol_simple = Role.create(name:'simple')
    user = User.create(role: rol_simple,  username: 'usr',password:'pass',password_confirmation:'pass',
                                    full_name:'sample user', email:'user@1234.com')
    sign_in user
    type_skype = FeedbackType.find_all_by_name('Skype')[0]
    p1 = Project.create(name: "Panaderia El 10",
                        description: "Software para administracion de una panaderia",
                        end_date: DateTime.new(2013,1,1),
                        finalized: false)
    feedback = Feedback.create(project: p1, user: user, feedback_type: type_skype, subject: "Email", content: "Ipsu")

    post :create, feedback_id: feedback.id, comment: {content: content, created_at: created_at}

    response.should redirect_to("/my_projects")

    findByName = Comment.find_all_by_content(content)

    findByName.size.should eq(1)
    findByName[0].content.should eq(content)

    sign_out user
  end

  it "def show" do
    Comment1= Comment.create(content: "Comment", created_at: Time.now)

    get :show, id: Comment1.id

    assert_response :success

    Comment2 = assigns[:comment]

    Comment1.content.should eq(Comment2.content)

  end


  it "def destroy" do
    contenido = 'Comment1'

    Comment1=Comment.create(content: contenido, created_at: Time.now)

    delete :destroy, id: Comment1.id

    response.should redirect_to(comments_path)

    Comment.find_all_by_content(contenido).size.should eq(0)
  end

  it "def update" do
    Comment1=Comment.create(content: "Comment 1", created_at: Time.now)

    put :update, id: Comment1.id, Comment: {Contenido:'Comment 2'}

    path = comments_path(assigns[:comment]).gsub(".", "/")
    response.should redirect_to(path)
  end
end
