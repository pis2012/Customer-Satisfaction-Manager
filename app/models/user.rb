class User < ActiveRecord::Base
  default_scope :order => 'full_name'
  scope :related_users, lambda { |text| where("full_name LIKE '%' :tag '%'", {:tag => text}) }
  scope :latest_related_users, lambda { |text,limit| related_users(text).limit(limit) }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :trackable, :encryptable,
  #:lockable, :timeoutable, :openid_authenticatable,


  devise :database_authenticatable, :registerable, :recoverable, :omniauthable, :rememberable, :confirmable, :validatable
  #after_create :create_profile

  belongs_to :role
  belongs_to :client
  has_one :profile
  has_many :feedbacks
  has_many :comments

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role,      :client,       :profile,   :feedbacks, :comments,    :unconfirmed_email,
                  :id,        :full_name,    :username,  :email,     :openidemail, :current_password,
                  :password,  :remember_me,  :role_id,   :client_id, :project_id,  :password_confirmation,
                  :forms,     :disable



  validates :username, :full_name, :email, :presence  => true
  validates :email, :username, :uniqueness => true

  validates_uniqueness_of :openidemail, :allow_blank => true

  validates_confirmation_of :password, :email


  validates_presence_of :password,:password_confirmation, :on => :create

  validates :email, :email_format => {:message => I18n.t('activerecord.errors.models.user.attributes.email.format') }


  def self.find_for_authentication(conditions={})
    conditions[:disable] = false
    find(:first, :conditions => conditions)
  end

  def self.find_for_open_id_google_apps(access_token, signed_in_resource=nil)
    data = access_token['info']
    user = User.find_by_openidemail(data['email'])
    if !user.nil?
        return user
    else
        role = Role.find_by_name Role::MOOVEIT_ROLE
        user = User.new(:email => data['email'],:openidemail => data['email'],:full_name => data['name'],:username => data['first_name'],:role_id => role.id)
        user.skip_confirmation!
        if user.save :validate => false
          user.create_profile
        end
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
        #role = Role.find_by_name Role::CLIENT_ROLE
        #client = Client.find_by_name 'Sony'
        #user = User.create(:email => data['email'],:openidemail => data['email'],:full_name => data['name'],:username => data['first_name'],:role_id => role.id,:client_id => client.id)
        #user.skip_confirmation!
        #user.save
        #return user
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

    if self.role.name == Role::CLIENT_ROLE
      #get all client's project order by name
      p = Project.find_all_by_client_id(self.client.id, :order => :name).first

      #set first as default project
      Profile.create(user:self, project:p,skype_usr:'')

    else
      #get all project order by name
      p = Project.all(:order => :name).first

      #set first as default project
      Profile.create(user:self, project:p,skype_usr:'')

    end

  end

  def possible_feedback_types
    if self.role.name == Role::CLIENT_ROLE
      FeedbackType.find(3,4)
    else
      FeedbackType.all
    end
  end

  def admin?
    self.role.name == Role::ADMIN_ROLE
  end

  def mooveit?
    self.role.name == Role::MOOVEIT_ROLE
  end

  def client?
    self.role.name == Role::CLIENT_ROLE
  end

  def skip_confirmation!
    self.confirmed_at = Time.now
  end

  def self.send_feedback_notification(feedback)
    interestedUsers = Project.find(feedback.project_id).client.users

    interestedUsers.each do|interestedUser|
      profile = Profile.find_by_user_id(interestedUser.id)
      if profile.feedbacks_notifications
        NotificationMailer.feedback_notification_email(feedback,interestedUser).deliver
      end
    end
  end

  def self.send_comment_notification(comment)
    interestedUsers = Project.find(comment.feedback.project_id).client.users

    interestedUsers.each do|interestedUser|
      profile = Profile.find_by_user_id(interestedUser.id)
      if profile.comments_notifications
        NotificationMailer.comment_notification_email(comment,interestedUser).deliver
      end
    end
  end

  # This cannot be turned into scope. It's an opened issue in rails repository
  def self.recent_users(date)
    User.unscoped.where('created_at >= ?', date).order('created_at desc')
  end

  def self.latest_recent_users(date,limit)
    User.unscoped.where('created_at >= ?', date).order('created_at desc').limit(limit)
  end

end
