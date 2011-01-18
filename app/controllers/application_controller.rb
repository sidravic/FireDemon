class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :current_user_session
  helper_method :clear_current_session

  def client_session(xmpp_client)
    session[:xmpp_client] = xmpp_client
  end
  
  def clear_client_session
    session[:xmpp_client] = nil
  end
  
  private


  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def clear_current_session
    current_user_session.destroy if current_user_session
  end
end
