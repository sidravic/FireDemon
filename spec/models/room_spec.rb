require 'spec_helper'

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
    @room = Factory.create(:room, :user => @user, :nick => 'room_101')
    @room_2 = Factory.build(:room, :user => @user, :nick => 'room_101')
    @room_2.should have(1).errors_on(:nick)
  end
  
end
