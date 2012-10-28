require 'spec_helper'
require 'comments_controller'

describe CommentsController, :type => :controller do

  before :all do
    User.delete_all
    Project.delete_all
    FeedbackType.delete_all
    Role.delete_all
    @valid_attributes =
        {
            :adusr => User.create(role: Role.create(name:'Admin'),  username: 'usr',password:'pass',password_confirmation:'pass',
                                full_name:'sample user', email:'user@1234.com'),
            :usr => User.create(role: Role.create(name:'simple'),  username: 'usr',password:'pass',password_confirmation:'pass',
                                full_name:'sample user', email:'user@1234.com'),
            :project => Project.create(name: "Panaderia El 10",
                                 description: "Software para administracion de una panaderia",
                                 end_date: DateTime.new(2013,1,1),
                                 finalized: false) ,
            :type_skype => FeedbackType.create(name: "Skype", image_url: "dasd")

        }
  end


  it "def create" do
    content = 'Comment1'
    created_at = Time.now
    user = @valid_attributes[:adusr]
    sign_in user
    type_skype = @valid_attributes[:type_skype]
    p1 = @valid_attributes[:project]
    feedback = Feedback.create(project: p1, user: user, feedback_type: type_skype, subject: "Email", content: "Ipasdasdasd asdasdasdasda sdas das das as asd asd as das d asd ads as das das das da dsdasdbas asd asdasdsada s as dasd asd asdas das d asd asdas dasd asdasdas dasu")

    post :create, feedback_id: feedback.id, comment: {content: content, created_at: created_at}, format: 'js'

    assert_response :success

    sign_out user
  end


  it "def destroy" do
    user = @valid_attributes[:adusr]
    sign_in user
    content = 'Comment1 asdadasd asdasdas dasdas das dasdasd adsdad '
    type_skype = @valid_attributes[:type_skype]
    p1 = @valid_attributes[:project]
    feedback = Feedback.create(project: p1, user: user, feedback_type: type_skype, subject: "Email", content: "Ipasdasdasd asdasdasdasda sdas das das as asd asd as das d asd ads as das das das da dsdasdbas asd asdasdsada s as dasd asd asdas das d asd asdas dasd asdasdas dasu")
    Comment1=Comment.create(content: content, created_at: Time.now, feedback: feedback, user: user)

    delete :destroy, id: Comment1.id

    response.should redirect_to(comments_path)

    sign_out user
  end


end
