require 'spec_helper'

class ActivitiesHelperSpec
  describe ActivitiesHelper, :type => :helper do

    before :all do
      User.delete_all
      Project.delete_all
      FeedbackType.delete_all
      Role.delete_all
      Client.delete_all

      client = Client.create(name: "Client 1")
      @valid_attributes =
          {
              :adusr => User.new(role: Role.create(name:'Admin'),  username: 'usr',password:'pass',password_confirmation:'pass',
                                 full_name:'sample user', email:'user@1234.com'),
              :project => Project.create(name: "Panaderia El 10", client: client,
                                         description: "Software para administracion de una panaderia",
                                         end_date: DateTime.new(2013,1,1),
                                         finalized: false) ,
              :type_skype => FeedbackType.create(name: "Skype", image_url: "dasd"),
          }

      @valid_attributes[:client] = client
      @valid_attributes[:adusr].skip_confirmation!
      @valid_attributes[:profile] = Profile.create(user: @valid_attributes[:adusr], project:@valid_attributes[:project], skype_usr:'martin.skype')
      @valid_attributes[:adusr].profile = @valid_attributes[:profile]
      @valid_attributes[:adusr].save :validate => false
      @valid_attributes[:view] = {:project => @valid_attributes[:project]  }
      @valid_attributes[:milestonedata] = {:name => "Mile", :project_id =>  @valid_attributes[:project].id, :target_date => Time.now  }

      mood = @valid_attributes[:project].moods.create(:status => 5, :project => @valid_attributes[:project])
      @valid_attributes[:project].mood = mood
      @valid_attributes[:mood] = mood

      @valid_attributes[:feedback] = Feedback.create(project: @valid_attributes[:project],
                                 user: @valid_attributes[:adusr],
                                 feedback_type: @valid_attributes[:type_skype],
                                 subject: "Email",
                                 content: "Ipasdasdasd asdasdasdasda sdas das das as asd asd as das d asd ads as das das das da dsdasdbas asd asdasdsada s as dasd asd asdas das d asd asdas dasd asdasdas dasu")

      @valid_attributes[:comment] = Comment.create({user: @valid_attributes[:adusr], content: "content", feedback_id: @valid_attributes[:feedback].id})

    end

    it "activity_avatar" do
      helper.activity_avatar @valid_attributes[:project]
      helper.activity_avatar @valid_attributes[:adusr]
      helper.activity_avatar @valid_attributes[:client]
      helper.activity_avatar ""
    end

    it "activity_action" do
      helper.activity_action(@valid_attributes[:project],true)
      helper.activity_action(@valid_attributes[:adusr],true)
      helper.activity_action(@valid_attributes[:client],true)
      helper.activity_action("" ,true)

      helper.activity_action(@valid_attributes[:project],false)
      helper.activity_action(@valid_attributes[:adusr],false)
      helper.activity_action(@valid_attributes[:client],false)
      helper.activity_action("" ,false)
    end

    it "user_image_tag" do
      helper.user_image_tag @valid_attributes[:adusr]
    end

    it "activity_image_tag" do
      helper.activity_image_tag @valid_attributes[:feedback]
      helper.activity_image_tag @valid_attributes[:mood]
      helper.activity_image_tag @valid_attributes[:comment]
      helper.activity_image_tag @valid_attributes[:project]
      helper.activity_image_tag @valid_attributes[:adusr]
      helper.activity_image_tag @valid_attributes[:client]
      helper.activity_image_tag ""
    end

    it "activity_link" do
      helper.activity_link @valid_attributes[:feedback]
      helper.activity_link @valid_attributes[:mood]
      helper.activity_link @valid_attributes[:comment]
      helper.activity_link @valid_attributes[:project]
      helper.activity_link ""
    end

    it "activity_action_name" do
      helper.activity_action_name(@valid_attributes[:feedback],true)
      helper.activity_action_name(@valid_attributes[:mood],true)
      helper.activity_action_name(@valid_attributes[:comment],true)
      helper.activity_action_name( @valid_attributes[:project],true)
      helper.activity_action_name(@valid_attributes[:adusr],true)
      helper.activity_action_name(@valid_attributes[:client],true)
      helper.activity_action_name("",true)

      helper.activity_action_name(@valid_attributes[:feedback],false)
      helper.activity_action_name(@valid_attributes[:mood],false)
      helper.activity_action_name(@valid_attributes[:comment],false)
      helper.activity_action_name( @valid_attributes[:project],false)
      helper.activity_action_name(@valid_attributes[:adusr],false)
      helper.activity_action_name(@valid_attributes[:client],false)
      helper.activity_action_name("",false)
    end

    it "activity_date" do
      helper.activity_date @valid_attributes[:feedback]
      helper.activity_date @valid_attributes[:mood]
      helper.activity_date @valid_attributes[:comment]
      helper.activity_date @valid_attributes[:project]
      helper.activity_date @valid_attributes[:adusr]
      helper.activity_date @valid_attributes[:client]
      helper.activity_date ""
    end

    it "activity_content" do
      helper.activity_content @valid_attributes[:feedback]
      helper.activity_content @valid_attributes[:comment]
      helper.activity_content @valid_attributes[:project]
      helper.activity_content ""
    end


  end

end


