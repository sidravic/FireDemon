require "redis_wrapper"

class RoomObserver < ActiveRecord::Observer

  def after_create(room)
    # add room to Redis room list
    raise "Could not add Room Nick to Redis" unless RedisWrapper::Set::Redis.add('rooms', room.nick)    
  end
end
