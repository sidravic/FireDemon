class Room < ActiveRecord::Base
  require 'xmpp_client'
  require 'muc_client'

  has_one :jabber_credential, :dependent => :destroy
  belongs_to :user

  validates :nick, :presence             => true,
                   :uniqueness           => true


#  def join(domain = 'siddharth-ravichandrans-macbook-pro.local') 
#  end
  
  
end
