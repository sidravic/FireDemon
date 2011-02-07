require 'spec_helper'
require 'redis_wrapper'
describe Room do
  
  before(:each) do
    @user = Factory.build(:user)
    @user.stub!(:register_jabber).and_return(true)  
    @room = Factory.build(:room, :user => @user, :nick => "")    
  end
  
  it "should have a valid name for the room" do
    @room.should have(1).errors_on(:nick)
  end
  
  it "should check for a unique room_name" do
    RedisWrapper::All::Redis.flushall
    @room = Factory.create(:room, :user => @user, :nick => 'room_101')
    @room_2 = Factory.build(:room, :user => @user, :nick => 'room_101')
    @room_2.should have(1).errors_on(:nick)
  end
  
  
  context "Adminstrator Login to a room" do
    it "should login the admin if adminstrator is not already in" do
      RedisWrapper::All::Redis.flushall
      @room = Factory.create(:room, :user => @user, :nick => "bazingaaa")     
      puts "[ ROOM ]" + @room.inspect
      RedisWrapper::Set::Redis.remove("rooms:bazingaaa", "administrator") if RedisWrapper::Set::Redis.member?("rooms:bazingaaa", "administrator")
      @room.login
      RedisWrapper::Set::Redis.member?("rooms:#{@room.nick}", "administrator").should == true
    end
  end
end
