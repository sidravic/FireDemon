class User < ActiveRecord::Base
  require 'xmpp_client'

  has_one  :jabber_credential, :dependent => :destroy
  has_many :rooms, :dependent            => :destroy
  
  acts_as_authentic
  
  validates :email, :presence            => true,
                    :format              => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :name, :presence             => true,
                   :length               => {:maximum => 60 }

  scope :activated, where(["activated    = ?", true])
  
  def self.activated_user(email)
    User.find_by_email_and_activated(email, true)
  end
                     

  def activate
    self.activated                       = true
    save(:validate => false)
  end
  
  def register_jabber
    xmpp_client = XmppClient.new(self.jabber_credential.jabber_id)    
    xmpp_client.register(self.jabber_credential.jabber_password)
    xmpp_client.close
  end
end
