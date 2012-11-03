require 'spec_helper'

class ActivitySpec
  describe Activity do
    before :all do
      User.delete_all
      Project.delete_all
      FeedbackType.delete_all
      Role.delete_all
      @valid_attributes =
          {
              :adusr => User.new(role: Role.create(name:'Admin'),  username: 'usr',password:'pass',password_confirmation:'pass',
                                 full_name:'sample user', email:'user@1234.com'),
              :project => Project.create(name: "Panaderia El 10",
                                         description: "Software para administracion de una panaderia",
                                         end_date: DateTime.new(2013,1,1),
                                         finalized: false) ,
              :type_skype => FeedbackType.create(name: "Skype", image_url: "dasd")

          }

      @valid_attributes[:adusr].skip_confirmation!
      @valid_attributes[:adusr].save :validate => false
    end

    it "initialize" do
       act = Activity.new("action", "author", Time.now, "image_path")
    end

    it "recent_activity" do
      content = 'Comment1'
      created_at = Time.now
      user = @valid_attributes[:adusr]
      p1 =     @valid_attributes[:project]
      type_skype = @valid_attributes[:type_skype]
      mood = Mood.create(:project => p1, :created_at => Time.now,  :status => 5)
      feedback = Feedback.create(project: p1, user: user, feedback_type: type_skype, subject: "Email", content: "Ipasdasdasd asdasdasdasda sdas das das as asd asd as das d asd ads as das das das da dsdasdbas asd asdasdsada s as dasd asd asdas das d asd asdas dasd asdasdas dasu")
      comment = Comment.create(:feedback => feedback, :user => user,:feedback_id => feedback.id,  :user_id => user.id,
                                    :content => "Ipasdasdasd asdasdasdasda sda asd asdasdsada s as dasd asd asdas das d asd asdas dasd asdasdas dasu",
                                    :created_at => Time.now, :updated_at => Time.now)

      Activity.recent_activity(Time.now - 30.days,10)
    end

    it "activity_filter" do
      Activity.activity_filter("hadoken")
    end
  end
end