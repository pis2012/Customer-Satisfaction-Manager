require 'spec_helper'

describe ProfilesController, :type => :controller do

  before :all do
    User.delete_all
    Project.delete_all
    Client.delete_all
    Role.delete_all
    @valid_attributes =
        { :project=>Project.create(name: "Projecto test",
                                   description: "projecto test",
                                   end_date:'2013-01-01 00:00:00',
                                   finalized: false),
          :user => User.new(role:  Role.create(name:'simple'), client: Client.create(name:'MicroHard2'),
                               username: 'user1',password:'user1',password_confirmation:'user1',
                               full_name:'Martin Cabrera', email:'cabrera2@1234.com')
        }

    @valid_attributes[:user].skip_confirmation!
    @valid_attributes[:user].save :validate => false
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested profile" do
        user = @valid_attributes[:user]
        sign_in user
        profile = Profile.create! @valid_attributes

        put :update, id: profile.id, profile: {user_id:profile.user.id},user: {password: profile.user.password}

        response.should redirect_to("/")
        sign_out user
      end
    end
  end

end
