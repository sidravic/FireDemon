class Room < ActiveRecord::Base
  has_one :jabber_credential, :dependent => :destroy
  belongs_to :user

  validates :nick, :presence             => true,
                   :uniqueness           => true

end
