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

    it "return http success" do
      response.should be_success
    end
  end

  describe "POST create" do
   let(:bob) { Fabricate(:user)}
   before { set_current_user(bob)}
   let(:eve) { Fabricate(:user)}
    it "should create new friends" do
      pending
    end
    it "should redirect to friends url" do
      post :create,  friend_id: bob.id
        response.should redirect_to people_url
    end
  end
end
