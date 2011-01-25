class UserObserver < ActiveRecord::Observer
  def after_create(user)
    jabber_credentials = user.build_jabber_credential
    jabber_credentials.jabber_id = "#{user.id}_#{user.name.split.join}_#{rand(100)}"
    jabber_credentials.jabber_password = '12345'
    jabber_credentials.save    
    user.register_jabber
  end
end
