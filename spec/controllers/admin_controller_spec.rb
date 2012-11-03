require 'spec_helper'

class AdminControllerSpec
  describe AdminController, :type => :controller do

    before :all do
      User.delete_all

      @valid_attributes =
          {
              :usr => User.new(role: Role.create(name:'Admin'), client: Client.create(name:'MicroHard'),
                                  username: 'admin4',password:'admin',password_confirmation:'admin',
                                  full_name:'Martin Cabrera', email:'ca5brera@1234.com')
          }

      @valid_attributes[:usr].skip_confirmation!
      @valid_attributes[:usr].save :validate => false
    end

  end
end