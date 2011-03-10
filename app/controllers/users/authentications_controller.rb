class Users::AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
    already_authed = []
    @authentications.each do |auth|
      already_authed << auth.provider
    end
    providers = User.omniauth_providers.map {|oa| oa.to_s }
    @providers_noauth = providers - already_authed
  end
  
end