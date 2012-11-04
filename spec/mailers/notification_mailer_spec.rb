require 'spec_helper'

class NotificationMailerSpec
  describe NotificationMailer do
    before :all do
      Profile.delete_all
      FeedbackType.delete_all
      User.delete_all
      Client.delete_all
      Role.delete_all
      Project.delete_all
      client = Client.create(name:'MicroHard')
      @valid_attributes =
          {
              :usr => User.new(role: Role.create(name:'Admin'), client: client,
                               username: 'admin4',password:'admin1',password_confirmation:'admin1',
                               full_name:'Martin Cabrera', email:'pis2012gr1@gmail.com')   ,
              :type_skype => FeedbackType.create(name:'Skype21',image_url:'/assets/feedbacks/generic.png')
          }

      @valid_attributes[:usr].skip_confirmation!
      @valid_attributes[:project2] = Project.create(client: client,
                                                    name:'Proyecto2',
                                                    description:'proyecto de verificadores',
                                                    end_date:'2013-01-01 00:00:00',
                                                    finalized:false)
      @valid_attributes[:usr].save :validate => false
    end

    it "feedback_notification_email" do
      feedback = Feedback.create(:feedback_type => @valid_attributes[:type_skype], :user => @valid_attributes[:usr],
                                 :project => @valid_attributes[:project2], :subject => "sasasas",
                                 :content => "asfsadfasdfsadflsadfsafdsadfsadmfhsakdjhfk s kjsadhfkjsa kjfashdkfjhsadlkjfhasdj fhjasdhf jsdahfjsadfs")
      feedback.project_id =  @valid_attributes[:project2].id
      NotificationMailer.feedback_notification_email(feedback,@valid_attributes[:usr])
    end

    it "comment_notification_email" do
      feedback = Feedback.create(:feedback_type => @valid_attributes[:type_skype], :user => @valid_attributes[:usr],
                                 :project => @valid_attributes[:project2], :subject => "sasasas",
                                 :content => "asfsadfasdfsadflsadfsafdsadfsadmfhsakdjhfk s kjsadhfkjsa kjfashdkfjhsadlkjfhasdj fhjasdhf jsdahfjsadfs")
      feedback.project_id =  @valid_attributes[:project2].id
      comment = Comment.create(:feedback => feedback, :user => @valid_attributes[:usr],
                               :content=> "asfsadfasdfsadflsadfsafdsadfsadmfhsakdjhfk s kjsadhfkjsa kjfashdkfjhsadlkjfhasdj fhjasdhf jsdahfjsadfs")

      NotificationMailer.comment_notification_email(comment,@valid_attributes[:usr])
    end

    it "reminder_email" do
      NotificationMailer.reminder_email(@valid_attributes[:project2],@valid_attributes[:usr])
    end
  end
end
