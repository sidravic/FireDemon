class MailAgent < ActionMailer::Base
  default :from => "from@example.com"
  default_url_options[:host] = 'localhost:3000'
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :from => 'locahost:3000', :subject => 'Registration Confirmation' )
  end
end
