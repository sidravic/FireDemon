Factory.define :user do |f|
  f.sequence(:name){ |n| "test_user_#{n}"}
  f.sequence(:email){|n| "test_user_#{n}@thankyou2010.com" }
  f.password "12345"
  f.password_confirmation "12345"
  f.password_salt "salt"
  f.perishable_token "perishable_token"
  f.persistence_token "75a2346dbf18c539f92be6d0eab2c7d092ddf0a2eb53d13126ed622336cdee169709674fe7d36ab0bbe7b804d4456944d0ba794d12e4738412a81b4cb2db0f82"
end

Factory.define :jabber_credential do |f|
  f.sequence(:jabber_id ){|n| "test_user_#{n}"}
  f.jabber_password "password"
  f.association :user
end

Factory.define :room do |f|
  f.sequence(:nick){|n| "room_nick_#{n}"}
  f.association :user
end
