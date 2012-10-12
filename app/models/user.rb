class User < ActiveRecord::Base
  default_scope :order => 'full_name'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :trackable, :encryptable, :confirmable,
  #:lockable, :timeoutable, :openid_authenticatable,

  devise :database_authenticatable, :registerable, :recoverable, :omniauthable, :rememberable
  after_create :create_profile

  belongs_to :role
  belongs_to :client
  has_one :profile
  has_many :feedbacks
  has_many :comments
  has_many :forms

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role, :client, :profile, :feedbacks, :comments, :forms,
                  :id, :full_name, :username, :email, :current_password, :password, :password_confirmation, :remember_me, :role_id, :client_id, :project_id


  validates :username, :full_name, :email, :presence  => true
  validates :email, :username, :uniqueness => true
  validates_confirmation_of :password

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token['info']

    if user = User.where(:email => data['email']).first
      return user
    else
      role = Role.find_by_name 'Mooveit'
      User.create!(:email => data['email'],:full_name => data['name'],:username => data['first_name'],:role_id => role.id)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.googleapps_data'] && session['devise.googleapps_data']['user_info']
        user = User.find_all_by_email data['email']
      end
    end
  end

  def create_profile
    if self.role.name == 'Mooveit'
      p = Project.all.first
      Profile.create(user:self, project:p,skype_usr:'')
    end
  end


end
