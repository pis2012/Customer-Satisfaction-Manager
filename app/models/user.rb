class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :trackable, :encryptable, :confirmable,
  #:lockable, :recoverable, :timeoutable, :rememberable, and :omniauthable

  devise :database_authenticatable, :registerable, :openid_authenticatable

  self.table_name = "csm_users"
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :role, :username, :identity_url, :email, :password, :password_confirmation

  def self.openid_required_fields
    ["http://axschema.org/namePerson/first", "http://axschema.org/namePerson/last", "http://axschema.org/contact/email"]
  end

  def self.build_from_identity_url(identity_url)
    User.new(:identity_url => identity_url)
  end

  def openid_fields=(fields)
    fields.each do |key, value|
      # Some AX providers can return multiple values per key
      if value.is_a? Array
        value = value.first
      end

      case key.to_s
        when "first", "http://axschema.org/namePerson/first"
          self.first_name = value
        when "last", "http://axschema.org/namePerson/last"
          self.last_name = value
        when "email", "http://axschema.org/contact/email"
          self.email = value
        else
          logger.error "Unknown OpenID field: #{key}"
      end


    end
  end

end
