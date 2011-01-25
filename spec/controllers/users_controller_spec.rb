require 'spec_helper'

describe UsersController do
render_views

before(:each) do
  @user_attributes = Factory.attributes_for(:user)
  @user = User.new(@user_attributes)
  @user.stub_chain(:register_jabber).and_return(true)
end

 describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
 end

  describe "GET 'new'" do
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Firebird | Home")
    end
  end

  describe "POST 'create'" do
    it "should create a new user" do
      count = User.all.size
      User.stub!(:new).and_return(@user)
      post 'create', :user =>  @user_attributes
      User.all.size.should eql(count + 1)      
      response.should redirect_to new_user_url
    end
  end

  describe "GET 'show'" do
    it "should be successful" do      
      @user.save
      get 'show', :id => @user
      response.should be_success
    end
  end

  #describe "GET 'edit'" do
   # it "should be successful" do
  #    pending
  #    get 'edit'
  #    response.should be_success
  #  end
  #end

  #describe "GET 'update'" do
   # it "should be successful" do
  #    pending
  #    get 'update'
  #    response.should be_success
  #  end
  #end

  #describe "GET 'destroy'" do
   # it "should be successful" do
  #    pending
  #    get 'destroy'
  #    response.should be_success
  #  end
  #end

end
