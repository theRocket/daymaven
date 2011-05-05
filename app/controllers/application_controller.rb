class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :ensure_domain

  protected

  def ensure_domain
    if request.env['HTTP_HOST'] != 'daymaven.com' && Rails.env.production?
      redirect_to "http://daymaven.com" + request.request_uri, :status => 301
    end  
  end

end

