class PagesController < ApplicationController
  def home
    redirect_to new_user_url
  end

  def about
  end

  def contact
  end

end
