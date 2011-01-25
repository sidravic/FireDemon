class JabberCredential < ActiveRecord::Base
  validates :jabber_id, :uniqueness         => true,
                        :presence       => true


  belongs_to :user
end
