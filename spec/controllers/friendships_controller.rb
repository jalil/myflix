require 'spec_helper'

describe FriendshipsController do
  describe "POST #create" do
    it "should create a friendship" do
      bob = Fabricate(:user)
      eve = Fabricate(:user)
      session[:user_id] = bob.id
      friendship = bob.friendships.build(user_id: bob.id, friend_id: eve.id)
      post :create, friend_id: eve.id
      bob.friends.should ==[bob]
    end
  end
end
