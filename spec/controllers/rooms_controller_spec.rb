require 'spec_helper'
require "redis_wrapper"

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
    
    context "successful room creation" do
      it "should create a new room" do      
        count = Room.count
        RedisWrapper::Set::Redis.should_receive(:add).and_return(true)
        post "create", :room => Factory.attributes_for(:room, :user => @user), :user_id => @user        
        Room.count.should eql(count + 1)
        response.should redirect_to user_room_url(@user, assigns[:room])        
        
      end
      
      it "should add room to the list of rooms on Redis" do
        post "create", :room => Factory.attributes_for(:room, :user => @user), :user_id => @user
        RedisWrapper::Set::Redis.members('rooms').include?(assigns[:room].nick).should eql(true)
        
        if RedisWrapper::Set::Redis.members('rooms').include?(assigns[:room].nick)
          puts "\n [Expectation Fulfilled. Deleting from Redis]"
          RedisWrapper::Set::Redis.remove('rooms', assigns[:room].nick) 
        end
          
      end
    end
    
    context "on failure to create room" do
      it "should not create a new room without a valid nick" do
        count = Room.count
        post "create", :room => Factory.attributes_for(:room, :nick => '', :user => @user), :user_id => @user
        Room.count.should eql(count)
        response.should render_template("new")        
      end
    end       
  end
  
end

