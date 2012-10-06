require 'spec_helper.rb'
require 'rubygems'
require 'active_record'
#gem 'activerecord'
#require Rails.root.join('app/models/feedback')
#require Rails.root.join('app/models/project')
#require Rails.root.join('app/models/user')
#require Rails.root.join('app/models/role')
#require Rails.root.join('app/models/profile')
#require Rails.root.join('app/models/feedback_type')
#require Rails.root.join('app/models/client')

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

    rol_admin = Role.create(:name=>'Admin')
    #rol_admin.save
    rol_client = Role.create(:name=>'Client')
    #rol_client.save
    rol_mooveit = Role.create(:name=>'Mooveit')
    #rol_mooveit.save

    type_skype = FeedbackType.create(:name=>'Skype')
    type_email = FeedbackType.create(:name=>'Email')
    type_reconocimiento = FeedbackType.create(:name=>'Reconocimiento')
    type_comentario = FeedbackType.create(:name=>'Comentario')

    #type_skype.save
    #type_email.save
    #type_reconocimiento.save
    #type_comentario.save

    client1 = Client.create(:name=>"MicroHard")
    #client2 = Client.create(:name=>"Sony")

    #client1.save
    #client2.save

    end_date = DateTime.new(2013,1,1)

    admin_usr = User.create(:role=>rol_admin, :client=>client1,
                         :username=>'admin',:password=>'admin',:password_confirmation=>'admin',
                         :full_name=>'Martin Cabrera', :email=>'cabrera@1234.com')

    #admin_usr.save


    p1 = Project.create(:client=> client1,
                     :name=> "Panaderia El 10",
                     :description=> "Software para administracion de una panaderia",
                     :end_date=> end_date,
                     :finalized=> false)
    #p1.save

    profile1 = Profile.create(:user=>admin_usr, :project=>p1,
                           :last_login_date=>'2012-01-01 00:00:00', :skype_usr=>'martin.skype')

    #profile1.save

    @feedback=Feedback.create(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :subject=> "Email de requerimientos - interfaz",
                           :content=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    #@feedback.save

  end

  rol_admin = Role.create(:name=>'Admin')
  #rol_admin.save
  rol_client = Role.create(:name=>'Client')
  #rol_client.save
  rol_mooveit = Role.create(:name=>'Mooveit')
  #rol_mooveit.save

  type_skype = FeedbackType.create(:name=>'Skype')
  type_email = FeedbackType.create(:name=>'Email')
  type_reconocimiento = FeedbackType.create(:name=>'Reconocimiento')
  type_comentario = FeedbackType.create(:name=>'Comentario')

  #type_skype.save
  #type_email.save
  #type_reconocimiento.save
  #type_comentario.save

  client1 = Client.create(:name=>"MicroHard")
  #client2 = Client.create(:name=>"Sony")

  #client1.save
  #client2.save

  end_date = DateTime.new(2013,1,1)

  admin_usr = User.create(:role=>rol_admin, :client=>client1,
                       :username=>'admin',:password=>'admin',:password_confirmation=>'admin',
                       :full_name=>'Martin Cabrera', :email=>'cabrera@1234.com')

  #admin_usr.save


  p1 = Project.create(:client=> client1,
                   :name=> "Panaderia El 10",
                   :description=> "Software para administracion de una panaderia",
                   :end_date=> end_date,
                   :finalized=> false)
  #p1.save

  profile1 = Profile.create(:user=>admin_usr, :project=>p1,
                         :last_login_date=>'2012-01-01 00:00:00', :skype_usr=>'martin.skype')

  #profile1.save

  ########### Subject ###########
  it "should have a subject" do
    @feedback.should respond_to(:subject)
  end
  it "should not have an empty subject" do
    @feedback.subject.should_not == nil
    @feedback.subject.should_not be_empty
  end
  it "should give error when trying to save feedback without subject" do
    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                            :feedback_type=> type_skype,
                            :content=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end
  it "should give error when trying to save feedback with empty subject" do
    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                            :feedback_type=> type_skype, :subject=> "",
                            :content=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end
  it "should give error when trying to save feedback with nil subject" do
    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                            :feedback_type=> type_skype, :subject=> nil,
                            :content=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should ==false
  end

  ########### content ###########
  it "should have a content" do
    @feedback.should respond_to(:content)
  end
  it "should not have an empty content" do
    @feedback.content.should_not == nil
    @feedback.content.should_not be_empty
  end
  it "should give error when trying to save feedback without content" do

    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :subject=> "Email de requerimientos - interfaz")
    feedback2.save.should == false
  end
  it "should give error when trying to save user with empty content" do

    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :subject=> "Email de requerimientos - interfaz",
                           :content=> "")
    feedback2.save.should == false
  end
  it "should give error when trying to save user with nil content" do

    feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
                           :feedback_type=> type_skype, :subject=> "Email de requerimientos - interfaz",
                           :content=> nil)
    feedback2.save.should == false
  end

  it "should give error when trying to save a feedback with a invalid project" do
    pNotExists = Project.new(:client=> client1,
                             :name=> "No existe",
                             :description=> "Prueba de proyecto no existente",
                             :end_date=> end_date,
                             :finalized=> false)

    feedback2=Feedback.new(:project=> pNotExists, :user=> admin_usr,
                           :feedback_type=> type_skype, :subject=> "Email de requerimientos - interfaz",
                           :content=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end

  it "should give error when trying to save a feedback with a invalid user" do
    uNotExists = User.new(:role=>rol_admin, :client=>client1,
                          :username=>'noexiste',:password=>'noexiste',:password_confirmation=>'noexiste',
                          :full_name=>'Nombre no existente', :email=>'noexiste@1234.com')


    feedback2=Feedback.new(:project=> p1, :user=> uNotExists,
                           :feedback_type=> type_skype, :subject=> "Email de requerimientos - interfaz",
                           :content=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
    feedback2.save.should == false
  end

  #it "should give error when trying to save a feedback with a invalid feedback_type" do
  #  typeNotExists = FeedbackType.new(:name=>'NoExiste')
  #  feedback2=Feedback.new(:project=> p1, :user=> admin_usr,
  #                         :feedback_type=> typeNotExists, :subject=> "Email de requerimientos - interfaz",
  #                         :content=> " Ipsum dolor sit amet id, nobis feugiat similique usu ex.")
  #  feedback2.save.should == false
  #end

  it "should have a project that exists in the system" do
    Project.all.should include @feedback.project
  end
  it "should be in the projects from the feedback's project" do
    @feedback.project.feedbacks.should include @feedback
  end

  it "should have a user that exists in the system" do
    User.all.should include @feedback.user
  end

  it "should be in the feedbacks from the feedback's user" do
    @feedback.user.feedbacks.should include @feedback
  end

  it "should have a feedback_type that exists in the system" do
    FeedbackType.all.should include @feedback.feedback_type
  end

  #it "should be in the feedback_type from the feedback's feedback_type" do
  #  @feedback.feedback_type.feedbacks.should include @feedback
  #end

end
