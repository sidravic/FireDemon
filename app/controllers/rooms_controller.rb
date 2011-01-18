class RoomsController < ApplicationController
  layout 'chat'
  
  def index
    @rooms = current_user.rooms    
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(params[:room])
    if @room.save
      flash[:notice] = 'Your room has been successfully created'
      redirect_to new_user_room
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end

end
