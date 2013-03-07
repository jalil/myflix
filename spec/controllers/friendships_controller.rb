require 'spec_helper'

describe FriendshipsController do

   let(:bob) { Fabricate(:user)}
   before { set_current_user(bob)}

  describe "GET #index" do
    it "should get all friends" do
      eve =  Fabricate(:user)
      eve2 = Fabricate(:user)
      eve3 = Fabricate(:user)
      bob.friendships.create(user_id: bob.id, friend_id: eve.id)
      bob.friendships.create(user_id: bob.id, friend_id: eve2.id)
      bob.friendships.create(user_id: bob.id, friend_id: eve3.id)
      get :index
      bob.friends.should == [eve, eve2, eve3]
    end
    it "should render index template" do
      set_current_user(bob)
      get :index
      response.should render_template :index
    end
  end

  describe "POST create" do
   let(:bob) { Fabricate(:user)}
   before { set_current_user(bob)}
    it "should create new friendships" do
      eve = Fabricate(:friendship, user_id: bob.id)
      post :create, friend_id: eve.id
      bob.friendships.should == [ eve ]
    end 
    it "should redirect to friends url"
  end
end
