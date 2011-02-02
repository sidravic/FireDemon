class RoomObserver < ActiveRecord::Observer

  def after_create(room)
 #   room.join
  end
end
