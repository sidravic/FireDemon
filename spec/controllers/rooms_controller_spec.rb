require 'spec_helper'

describe RoomsController do
  render_views
  before(:each) do
    @user = Factory.build(:user)
    @user.stub!(:register_jabber).and_return(true)
    @user.save!
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index', :user_id => @user.id
      response.should have_selector("title", :content => "Rooms")
    end
  end
  
  describe "GET 'new'" do
    it "should render the new page" do
      get "new", :user_id => @user.id
      response.should have_selector("title", :content => "New Room")
    end
  end    
  
  describe "POST 'create'" do 
    it "should create a new room" do      
      count = Room.count
      post "create", :room => Factory.attributes_for(:room, :user => @user), :user_id => @user
      Room.count.should eql(count + 1)
    end
  end
end

