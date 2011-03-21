class User < ActiveRecord::Base
  has_many :authentications
  has_many :days
  has_many :ratings
  has_many :rated_days, :through => :ratings, :source => :days
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def self.new_with_session(params, session)
    super.tap do |user|
      #can access things like session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
      #if not persisting the user
    end
  end
  
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    user = User.find_by_email(data["email"])
    if user.nil? # Create an user with a stub password. 
      user = User.create!(:name => data["name"], :email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
    if user.authentications.find_by_provider('facebook').nil? # Create an authentication with the FB token. 
      user.authentications.build(:provider => access_token['provider'], :uid => access_token['uid'], :token => access_token['credentials']['token'])
    end
    return user
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end
  
  def add_twitter_oauth(access_token)
    #only permitted on existing user
    if authentications.find_by_provider('twitter').nil? # Create an authentication with the FB token. 
      auth = authentications.build(:provider => access_token['provider'], :uid => access_token['uid'], :token => access_token['credentials']['token'], :secret => access_token['credentials']['secret'])
      auth.save #not sure why build doesn't do this automagically
    end
  end

end
