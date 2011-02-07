class Room < ActiveRecord::Base
  require 'xmpp_client'
  require 'muc_client'
  require 'redis_wrapper'

  has_one :jabber_credential, :dependent => :destroy
  belongs_to :user

  validates :nick, :presence             => true,
                   :uniqueness           => true

  # currently only controls administrator login. 
  def login(user = 'administrator', domain = 'siddharth-ravichandrans-macbook-pro.local')    
    unless RedisWrapper::Set::Redis.member?("rooms:#{self.nick}", user)
        Jabber::debug = true  if Rails.env == "development"   
        xmpp_client = XmppClient.login(user)        
        muc = MucClient.new(xmpp_client)
        if muc.join(self.nick)        
          RedisWrapper::Set::Redis.add("rooms:#{self.nick}", user)
          muc.activate_callbacks          
        end
    end
  end  

end
