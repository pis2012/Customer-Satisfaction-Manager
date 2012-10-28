class User < ActiveRecord::Base
  default_scope :order => 'full_name'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :trackable, :encryptable,
  #:lockable, :timeoutable, :openid_authenticatable,


  devise :database_authenticatable, :registerable, :recoverable, :omniauthable, :rememberable, :confirmable
  after_create :create_profile

  belongs_to :role
  belongs_to :client
  has_one :profile
  has_many :feedbacks
  has_many :comments
  has_many :forms

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role,      :client,       :profile,   :feedbacks, :comments,    :unconfirmed_email,
                  :id,        :full_name,    :username,  :email,     :openidemail, :current_password,
                  :password,  :remember_me,  :role_id,   :client_id, :project_id,  :password_confirmation,
                  :forms



  validates :username, :full_name, :email, :presence  => true
  validates :email, :username, :uniqueness => true
  validates_confirmation_of :password, :email


  def self.find_for_open_id_google_apps(access_token, signed_in_resource=nil)
    data = access_token['info']

    if user = User.find_by_openidemail(data['email'])
        return user
      else
        role = Role.find_by_name Role::MOOVEIT_ROLE
        client = Client.find_by_name 'Sony'
        user = User.create(:email => data['email'],:openidemail => data['email'],:full_name => data['name'],:username => data['first_name'],:role_id => role.id,:client_id => client.id)
        user.skip_confirmation!
        user.save
        return user
    end
  end

  def self.find_for_open_id_google(access_token, signed_in_resource=nil)
    data = access_token['info']

    if !signed_in_resource.nil?
      user =  User.find_by_id(signed_in_resource.id)
      user.openidemail = data['email']
      user.save
      return user
    else
      if user = User.find_by_openidemail(data['email'])
        return user
      else
        role = Role.find_by_name Role::CLIENT_ROLE
        client = Client.find_by_name 'Sony'
        user = User.create(:email => data['email'],:openidemail => data['email'],:full_name => data['name'],:username => data['first_name'],:role_id => role.id,:client_id => client.id)
        user.skip_confirmation!
        user.save
        return user
      end
    end
  end

  #def self.new_with_session(params, session)
  #super.tap do |user|
  #if data = session['devise.googleapps_data'] && session['devise.googleapps_data']['user_info']
  #user = User.find_all_by_email data['email']
  #end
  #end
  #end

  def create_profile
    if self.role.name == Role::MOOVEIT_ROLE
      p = Project.all.first
      Profile.create(user:self, project:p,skype_usr:'')
    elsif self.role.name == Role::CLIENT_ROLE
      p = Project.all.first
      Profile.create(user:self, project:p,skype_usr:'')
    end
  end

  def admin?
    return self.role.name == Role::ADMIN_ROLE
  end

  def mooveit?
    return self.role.name == Role::MOOVEIT_ROLE
  end

  def client?
    return self.role.name == Role::CLIENT_ROLE
  end

end
