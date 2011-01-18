class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    user_session = UserSession.new(params[:user_session])
    if user_session.save
      flash[:notice] = "Your account was successfully created. A verification email has been sent to your account."
      redirect_to user_url(current_user)
    else
      flash[:error] = "Invalid Username or Password"
      redirect_to new_user_session_url
    end
  end

  def destroy
    user_session = UserSession.find
    user_session.destroy
    redirect_to home_url
  end

end
