class JabberCredential < ActiveRecord::Base
  validates :jabber_id, :unique         => true,
                        :presence       => true


  belongs_to :user
end
