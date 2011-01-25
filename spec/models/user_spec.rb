require 'spec_helper'

describe User do
  before(:each) do
    @user  = Factory.build(:user, :email => "")    
    @user.stub!(:register_jabber)
  end
  
  it "should validate presence of email" do
    @user.should_not be_valid
  end
  
  it "should validate presence of email" do
    @user.email = 'test_user_1@thankyou2010.com'
    @user.should be_valid
  end
  
  
  it "should validate format of email" do
    @user.email = 'tt.com'
    @user.should_not be_valid
  end
  
  it "should validate format of email " do
    @user.email = 'test_user_1@thankyou2010.com'
    @user.should be_valid
  end
  
  it "should validate presence of name" do
    @user.name = ""
    @user.should_not be_valid
  end
  
  it "activate a given account" do
    @user.email = 'test_user_1@thankyou2010.com'
    @user.stub!(:register_jabber).and_return("Jabber Registered")
    @user.activate
    @user.activated.should eql(true)
  end
  
  it "should register a jabber account for a user" do
   @user.email = 'test_user_1@thankyou2010.com'  
   @user.save!
   @user.jabber_credential.jabber_id.should_not be_nil
   @user.jabber_credential.jabber_password.should_not be_nil
  end
end
