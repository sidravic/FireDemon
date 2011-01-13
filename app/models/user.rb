class User < ActiveRecord::Base
  acts_as_authentic
  
  validates :email, :presence => true,
                    :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :name, :presence => true,
                   :length => {:maximum => 60 }


  def self.activated_user(email)
    User.find_by_email_and_activated(email, true)
  end
                     

  def activate
    self.activated = true
    save(false)
  end
end
