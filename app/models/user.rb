class User < ActiveRecord::Base
  has_many :authentications
  has_many :days
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
          user.email = data["email"]
      end
    end
  end
  
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    user = User.find_by_email(data["email"])
    if user.nil? # Create an user with a stub password. 
      user = User.create!(:name => data["name"], :email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
    user.authentications.build(:provider => access_token['provider'], :uid => access_token['uid'], :token =>(access_token['credentials']['token'] rescue nil))
    return user
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end


  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
end
