class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    sign_in_and_redirect @user, :event => :authentication
  end
  
  def twitter
    if current_user #not autenticating with Twitter, just adding auth to existing user
      current_user.add_twitter_oauth(env["omniauth.auth"])
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect current_user, :event => :authentication
    end 
  end
end