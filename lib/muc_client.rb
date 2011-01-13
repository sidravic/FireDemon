class MucClient
  require 'xmpp4r'
  require 'xmpp4r/muc'
  
  include Jabber

  attr_reader :xmpp_client, :muc, :room_jid
# accepts an xmpp_client object
  def initialize(xmpp_client)
    @xmpp_client = xmpp_client
    @muc = Jabber::MUC::MUCClient.new(@xmpp_client.client)
  end

# allows a user to join a MUC chat room
  def join(room_jid, domain = 'siddharth-ravichandrans-macbook-pro.local')
    @room_jid = room_jid
    jid = Jabber::JID.new("#{@room_jid}@conference.#{domain}/" + @xmpp_client.client.jid.node)
    p " JID " + jid.to_s

    @muc.join(Jabber::JID.new("#{room_jid}@conference.#{domain}/" + @xmpp_client.client.jid.node))
    p "[JOINED ROOM] " + @muc.roster.inspect
  end

  def activate_callbacks
    activate_join_callback
    activate_message_callback
    activate_leave_callback
  end

  def activate_join_callback
    @muc.add_join_callback do |m|
      p "[NEW MEMBER JOINED] " + m.to.jid.node
    end
  end

  def activate_message_callback
    @muc.add_message_callback do |m|
      p "[NEW MESSAGE]" + m.body
    end
  end

  def activate_leave_callback
    @muc.add_leave_callback do |m|
      p "[MEMBER LEFT] " + m.to.jid.node
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
