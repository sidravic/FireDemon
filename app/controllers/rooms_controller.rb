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
      redirect_to user_room_url(current_user, @room)
    else
      flash.now[:error] = 'Oops there seems to be a few problem in creating the room'
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
  end
  
  def join
    @room = Room.find(params[:id])
    @room.join
    render 'show'
  end

  def edit
  end

  def update
  end

  def delete
  end

end
