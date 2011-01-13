class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create    
    @user = User.new(params[:user])
    if @user.save
      MailAgent.registration_confirmation(@user).deliver
      flash[:notice] = 'An email has been sent to your email account. Please verify your email address.'
      redirect_to new_user_url
    else
      flash.now[:error] = 'Please fix the listed errors'
      render 'new'
    end
  end

  def activate    
    @user = User.find_by_perishable_token(params[:token])
    if @user.activate
      flash[:notice] = 'Awesome! Your account has been activated. You may now log in and use FireBird to chat with your teams'
      redirect_to new_user_url
    else
      flash[:error] = 'The token seems to be invalid.'
      redirect_to new_user_url
    end
  end

  def show
    
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
