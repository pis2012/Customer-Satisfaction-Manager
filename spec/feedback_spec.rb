require 'spec_helper.rb'
require 'rubygems'
gem 'activerecord'
require 'active_record'
require Rails.root.join('app/models/feedback')
require Rails.root.join('app/models/project')
require Rails.root.join('app/models/user')
require Rails.root.join('app/models/role')
require Rails.root.join('app/models/profile')
require Rails.root.join('app/models/feedback_type')
require Rails.root.join('app/models/client')

describe Feedback do
  before(:all) do
    ActiveRecord::Base.establish_connection(
        :adapter=>'mysql2',
        :database=>'CSM_test',
        :username=> 'csmtestuser',
        :password=> 'password',
        :pool=> '5',
        :timeoute=> '5000')
    Role.delete_all
    FeedbackType.delete_all
    User.delete_all
    Client.delete_all
    Project.delete_all
    Milestone.delete_all
    Mood.delete_all
    Profile.delete_all
    Feedback.delete_all

    rol_admin = Role.new(:name=>'Admin')
    rol_admin.save
    rol_client = Role.new(:name=>'Client')
    rol_client.save
    rol_mooveit = Role.new(:name=>'Mooveit')
    rol_mooveit.save

    type_skype = FeedbackType.new(:name=>'Skype')
    type_email = FeedbackType.new(:name=>'Email')
    type_reconocimiento = FeedbackType.new(:name=>'Reconocimiento')
    type_comentario = FeedbackType.new(:name=>'Comentario')

    type_skype.save
    type_email.save
    type_reconocimiento.save
    type_comentario.save

    client1 = Client.new(:name=>"MicroHard")
    #client2 = Client.new(:name=>"Sony")

    client1.save
    #client2.save

    end_date = DateTime.new(2013,1,1)

    admin_usr = User.new(:role=>rol_admin, :client=>client1,
                         :username=>'admin',:password=>'admin',:password_confirmation=>'admin',
                         :full_name=>'Martin Cabrera', :email=>'cabrera@1234.com')

    admin_usr.save


    p1 = Project.new(:client=> client1,
                     :name=> "Panaderia El 10",
                     :description=> "Software para administracion de una panaderia",
                     :end_date=> end_date,
                     :finalized=> false)
    p1.save

    profile1 = Profile.new(:user=>admin_usr, :project=>p1,
                           :last_login_date=>'2012-01-01 00:00:00', :skype_usr=>'martin.skype')

    profile1.save

    @feedback=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :asunto=> "Email de requerimientos - interfaz",
                           :contenido=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    @feedback.save

  end

  rol_admin = Role.new(:name=>'Admin')
  rol_admin.save
  rol_client = Role.new(:name=>'Client')
  rol_client.save
  rol_mooveit = Role.new(:name=>'Mooveit')
  rol_mooveit.save

  type_skype = FeedbackType.new(:name=>'Skype')
  type_email = FeedbackType.new(:name=>'Email')
  type_reconocimiento = FeedbackType.new(:name=>'Reconocimiento')
  type_comentario = FeedbackType.new(:name=>'Comentario')

  type_skype.save
  type_email.save
  type_reconocimiento.save
  type_comentario.save

  client1 = Client.new(:name=>"MicroHard")
  #client2 = Client.new(:name=>"Sony")

  client1.save
  #client2.save

  end_date = DateTime.new(2013,1,1)

  admin_usr = User.new(:role=>rol_admin, :client=>client1,
                       :username=>'admin',:password=>'admin',:password_confirmation=>'admin',
                       :full_name=>'Martin Cabrera', :email=>'cabrera@1234.com')

  admin_usr.save


  p1 = Project.new(:client=> client1,
                   :name=> "Panaderia El 10",
                   :description=> "Software para administracion de una panaderia",
                   :end_date=> end_date,
                   :finalized=> false)
  p1.save

  profile1 = Profile.new(:user=>admin_usr, :project=>p1,
                         :last_login_date=>'2012-01-01 00:00:00', :skype_usr=>'martin.skype')

  profile1.save

  ########### Asunto ###########
  it "should have a asunto" do
    @feedback.should respond_to(:asunto)
  end
  it "should not have an empty asunto" do
    @feedback.asunto.should_not == nil
    @feedback.asunto.should_not be_empty
  end
  it "should give error when trying to save feedback without asunto" do
    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                            :feedback_type=> type_skype,
                            :contenido=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end
  it "should give error when trying to save feedback with empty asunto" do
    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                            :feedback_type=> type_skype, :asunto=> "",
                            :contenido=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end
  it "should give error when trying to save feedback with nil asunto" do
    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                            :feedback_type=> type_skype, :asunto=> nil,
                            :contenido=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should ==false
  end

  ########### Contenido ###########
  it "should have a contenido" do
    @feedback.should respond_to(:contenido)
  end
  it "should not have an empty contenido" do
    @feedback.contenido.should_not == nil
    @feedback.contenido.should_not be_empty
  end
  it "should give error when trying to save feedback without contenido" do

    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :asunto=> "Email de requerimientos - interfaz")
    feedback2.save.should == false
  end
  it "should give error when trying to save user with empty contenido" do

    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :asunto=> "Email de requerimientos - interfaz",
                           :contenido=> "")
    feedback2.save.should == false
  end
  it "should give error when trying to save user with nil contenido" do

    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :asunto=> "Email de requerimientos - interfaz",
                           :contenido=> nil)
    feedback2.save.should == false
  end

  it "should give error when trying to save a feedback with a invalid project" do
    pNotExists = Project.new(:client=> client1,
                             :name=> "No existe",
                             :description=> "Prueba de proyecto no existente",
                             :end_date=> end_date,
                             :finalized=> false)

    feedback2=Feedback.new(:project=> pNotExists, :user=> admin_usr,
                           :feedback_type=> type_skype, :asunto=> "Email de requerimientos - interfaz",
                           :contenido=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end

  it "should give error when trying to save a feedback with a invalid user" do
    uNotExists = User.new(:role=>rol_admin, :client=>client1,
                          :username=>'noexiste',:password=>'noexiste',:password_confirmation=>'noexiste',
                          :full_name=>'Nombre no existente', :email=>'noexiste@1234.com')


    feedback2=Feedback.new(:project=> p1, :user=> uNotExists,
                           :feedback_type=> type_skype, :asunto=> "Email de requerimientos - interfaz",
                           :contenido=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end

  it "should give error when trying to save a feedback with a invalid feedback_type" do
    typeNotExists = FeedbackType.new(:name=>'NoExiste')
    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> typeNotExists, :asunto=> "Email de requerimientos - interfaz",
                           :contenido=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end

  it "should have a project that exists in the system" do
    Project.all.should include @feedback.project
  end
  it "should be in the projects from the feedback's project" do
    @feedback.project.feedbacks.should include @feedback
  end

  it "should have a user that exists in the system" do
    User.all.should include @feedback.user
  end
  #it "should be in the feedbacks from the feedback's user" do
  #  @feedback.user.feedbacks.should include @feedback
  #end

  it "should have a feedback_type that exists in the system" do
    FeedbackType.all.should include @feedback.feedback_type
  end
  #it "should be in the feedback_type from the feedback's feedback_type" do
  #  @feedback.feedback_type.feedbacks.should include @feedback
  #end

end
