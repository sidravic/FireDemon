require 'xmpp4r'
require 'xmpp4r/client'
require 'xmpp4r/roster'

class XmppClient
  include Jabber

  attr_reader :client, :roster
  
  def initialize(jid, domain = 'siddharth-ravichandrans-macbook-pro.local')
  #  Jabber::debug =  true if Rails.env == 'development'
    puts "[Jabber ID] #{jid}@#{domain}"
    @client = Jabber::Client.new(Jabber::JID::new("#{jid}@#{domain}"))
    @client.connect            
  end

  def initialize_roster
    @roster = Jabber::Roster::Helper.new(@client)
  end
  
  def register(password)
    @client.register(password)
  rescue Jabber::ServerError => e
    puts "[Registration Failure]" + e.message
    if e.error_type == :modify
      instruction, fields = @client.register_info
      fields.each do  |info|
          puts "* #{info}"      
      end
      puts "instructions = #{instructions}"
    end
  end
  
  def self.login(jid, password = '123456', domain = 'siddharth-ravichandrans-macbook-pro.local')
    xmpp_client = XmppClient.new(jid)
    xmpp_client.authorize(password)
    xmpp_client
  rescue => e
    puts "[LOGIN FAILED] \n " + e.message + "\n" + e.backtrace.inspect
    return nil
  end

  def authorize(password = '123456')
    puts "[PASSWORD] **** #{password} *********"
    @client.auth(password)       
  end

  def set_presence(presence = :available)
    @client.send(Presence.new.set_type(presence))
  end

  
  # expects
  # to: pure jid of a user. Example : siddharth@siddharth-ravichandrans-macbook-pro.local but provide only 'siddharth' as value for to
  # message type can be :chat, :groupchat, :headline, :normal, :error
  #
  # the message type is because different clients react differently to message type
  # :normal message type opens a new window in Gajim where as a :chat continues an existing conversation
  #

  def send_message(to, msg, domain = 'siddharth-ravichandrans-macbook-pro.local', type = :chat)
    message = Message.new("#{to}@#{domain}", msg)
    message.type = type
    set_presence(:available)
    @client.send(message)
  end


  # expects
  # to: pure jid of a user. Example : siddharth@siddharth-ravichandrans-macbook-pro.local but provide only 'siddharth' as value for to
  
  def subscribe(to, domain = 'siddharth-ravichandrans-macbook-pro.local')
    @client.send(Presence.new.set_type(:subscribe).set_to("#{to}@#{domain}"))
  end

  def activate_callbacks
    activate_subscription_request_callback
    activate_presence_callback
    #  activate_update_callback
    activate_message_callback
  end

  # this sets up a callback for subscription requests and is different from subscription_callback
  # Subscription callback is activated whenever there is a change in presence
  # Subscription request callback gets called when the presence is :subscribe
  #
  #TODO: On Subscription Request update the user and have a separate method to accept and decline subscription requests
  #

  def activate_subscription_request_callback    
    @roster.add_subscription_request_callback do |item, presence|
    p "[ITEM] #{item}"
    p "[Presence] #{presence}"
    @roster.accept_subscription(presence.from)
   end
  end

  # identifies change in presence
  def activate_presence_callback
    @client.add_presence_callback do |old_presence, new_presence|
      p "[PRESENCE CALLBACK UPDATE] "
      p "[NEW PRESENCE OF] #{new_presence.from.to_s} IS #{new_presence.show}"
      # DO something with the new presence
    end
  end

  def activate_update_callback
    @client.add_update_callback do |presence|
      if presence.ask == :subscribe
        p "[UPDATE CALLBACK]"
        p "[UPDATE RESPONSE FROM] #{presence.from.to_s}"
      end
    end
  end


  def activate_message_callback
    @client.add_message_callback do |m|
      p "[MESSAGE FROM]: #{m.from}"
      p "[Message]: #{m.body}"
    end
  end

  def close
    @client.close
  end
end