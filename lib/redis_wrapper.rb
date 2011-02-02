require "redis"
REDIS = Redis.new

module RedisWrapper  
  module Set
    class Redis
      def self.add(key, value)
        REDIS.sadd(key, value)    
      end

      def self.members(key)
        REDIS.smembers(key)
      end

      def self.count(key)
        REDIS.card(key)
      end

      def self.member?(key, value)
        REDIS.sismember(key, value)
      end
      
      def self.remove(key, value)
        REDIS.srem(key, value)
      end      
    end    
  end   
  
  module All
    class Redis      
      def self.keys
        REDIS.keys
      end
    end
  end

end
