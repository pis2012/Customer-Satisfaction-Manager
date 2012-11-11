require 'spec_helper'

class MilestonesHelperSpec
  describe MilestonesHelper, :type => :helper do

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
              :type_skype => FeedbackType.create(name: "Skype", image_url: "dasd"),
          }

      @valid_attributes[:adusr].skip_confirmation!
      @valid_attributes[:adusr].save :validate => false
      @valid_attributes[:view] = {:project => @valid_attributes[:project]  }
      @valid_attributes[:milestonedata] = {:name => "Mile", :project_id =>  @valid_attributes[:project].id, :target_date => Time.now  }
    end

    it "get_milestones_data" do
      milestone = Milestone.new(@valid_attributes[:milestonedata])
      milestone.project_id = @valid_attributes[:project].id
      milestone.save

      assign(:project, @valid_attributes[:project])

      helper.get_milestones_data
    end

    it "get_milestone_date" do
      helper.get_milestone_date(Time.now)
    end
  end

end


