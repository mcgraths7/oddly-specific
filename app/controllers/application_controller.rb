class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  helper_method :current_user, :login!, :logout!

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end
  
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def must_be_logged_in!
    
  end
end
