class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :trackable, :encryptable, :confirmable,
  #:lockable, :timeoutable, :rememberable, :openid_authenticatable,

  devise :database_authenticatable, :registerable, :recoverable, :omniauthable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :role, :username, :email, :password, :password_confirmation

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token['info']

    if user = User.where(:email => data['email']).first
      return user
    else
      User.create!(:email => data['email'],:first_name => data['first_name'],:last_name => data['last_name'], :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.googleapps_data'] && session['devise.googleapps_data']['user_info']
        user.email = data['email']
        user.first_name = data['first_name']
        user.last_name = data['last_name']
      end
    end
  end

end
