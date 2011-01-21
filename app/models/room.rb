class Room < ActiveRecord::Base
  require 'xmpp_client'
  require 'muc_client'

  has_one :jabber_credential, :dependent => :destroy
  belongs_to :user

  validates :nick, :presence             => true,
                   :uniqueness           => true


  def join(domain = 'siddharth-ravichandrans-macbook-pro.local')
    # Really bad code but not sure why the method call throws authentication error
 #   client = Jabber::Client.new(Jabber::JID::new("#{self.user.jabber_credential.jabber_id}@#{domain}"))
#    client.connect
#    client.auth('12345')
#    muc = Jabber::MUC::MUCClient.new(client)
#    muc.join(Jabber::JID.new("#{self.nick}@conference.#{domain}/" + client.jid.node))
#    
#    muc.add_join_callback do |m|
#      puts "[NEW MEMBER JOINED] " + m.to.jid.node
#    end   
    
#   muc.add_message_callback do |m|
#      puts "[NEW MESSAGE]" + m.body
#    end  
    
#    puts "[ROOM JOINED BY] ------------- #{client.jid.to_s}"  
  end
  
  
end
