require 'xmpp_client'
require 'muc_client'



class JabberAdmin
  include Jabber
  
  def initialize(bare_jid ='administrator', password = '123456')
    Jabber::debug = true
    xmpp_client = XmppClient.new(bare_jid)
    xmpp_client.register(password)
    xmpp_client.close
  end  
end