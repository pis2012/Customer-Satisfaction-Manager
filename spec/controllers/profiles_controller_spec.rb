require 'spec_helper'

describe ProfilesController, :type => :controller do

  def valid_attributes
    { :project=>Project.create(name: "Projecto test",
                              description: "projecto test",
                              end_date:'2013-01-01 00:00:00',
                              finalized: false),
      :user => User.create(role:  Role.create(name:'simple'), client: Client.create(name:'MicroHard2'),
                         username: 'user1',password:'user1',password_confirmation:'user1',
                         full_name:'Martin Cabrera', email:'cabrera2@1234.com')
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProfilesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET edit" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes
      get :edit, {:id => profile.to_param}, valid_session
      assigns(:profile).should eq(profile)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested profile" do
        profile = Profile.create! valid_attributes

        put :update, id: profile.id, profile: {user_id:profile.user.id},user: {password: profile.user.password}

        assert_response :success
      end
    end
  end

end
