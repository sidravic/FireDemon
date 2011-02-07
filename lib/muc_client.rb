class MucClient
  require 'xmpp4r'
  require 'xmpp4r/muc'
  
  include Jabber

  attr_reader :xmpp_client, :muc, :room_jid
# accepts an xmpp_client object
  def initialize(xmpp_client)
    Jabber::debug = true if Rails.env == 'development'
    @xmpp_client = xmpp_client
    @muc = Jabber::MUC::MUCClient.new(@xmpp_client.client)
  end

# allows a user to join a MUC chat room
  def join(room_jid, domain = 'siddharth-ravichandrans-macbook-pro.local')
    @room_jid = room_jid
    jid = Jabber::JID.new("#{@room_jid}@conference.#{domain}/" + @xmpp_client.client.jid.node)
    puts " JID " + jid.to_s
    @muc.join(Jabber::JID.new("#{room_jid}@conference.#{domain}/" + @xmpp_client.client.jid.node))
    return true
    puts "[JOINED ROOM] " + @muc.roster.inspect
  rescue => e
    puts "[JOIN FAILED] \n" + e.message
    return false
  end

  def activate_callbacks
    activate_join_callback
    activate_message_callback
    activate_leave_callback
  end

  def activate_join_callback
    @muc.add_join_callback do |m|
      puts "[NEW MEMBER JOINED] " + m.to.jid.node
      send_message("#{m.to.jid.node} has joined the conversation")
    end
  end

  def activate_message_callback
    @muc.add_message_callback do |m|
      puts "[NEW MESSAGE]" + m.body
    end
  end

  def activate_leave_callback
    @muc.add_leave_callback do |m|
      puts "[MEMBER left] " + m.to.jid.node
      send_message("#{m.to.jid.node} has joined the conversation")
    end
  end

  def send_message(message, domain = 'siddharth-ravichandrans-macbook-pro.local')
    message = Jabber::Message.new("#{@room_jid}@conference.#{domain}", message)
    message.type = :groupchat
    @muc.send(message)
  end

  def leave
    @muc.exit
  end
end
