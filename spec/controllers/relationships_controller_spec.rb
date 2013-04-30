require 'spec_helper'

describe RelationshipsController do
  let(:alice) { Fabricate(:user) }
  before { set_current_user(alice) }

  describe "GET index" do
    it 'assigns @relationships' do
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, influencer: bob, follower: alice)
      get :index
      assigns(:relationships).should == [relationship]
    end

    it 'renders :index action' do
      get :index
      response.should render_template :index
    end

    it_behaves_like 'require_sign_in' do
      let(:action) { get :index }
    end
  end

  describe "DELETE destroy" do
    it "destroys that relationship" do
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      relationship_with_bob = Fabricate(:relationship, influencer: bob, follower: alice)
      relationship_with_charlie = Fabricate(:relationship, influencer: charlie, follower: alice)
      delete :destroy, id: relationship_with_bob.id
      alice.following_relationships.should == [relationship_with_charlie]
    end

    it "cannot destroy relationship that the current user is not a follower" do
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      relationship_with_bob = Fabricate(:relationship, influencer: alice, follower: bob)
      relationship_with_charlie = Fabricate(:relationship, influencer: charlie, follower: alice)
      delete :destroy, id: relationship_with_bob.id
      alice.influencing_relationships.should == [relationship_with_bob]
    end

    it "cannot destroy relationship that the current user is not a follower" do
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      bob_charlie_relationship = Fabricate(:relationship, influencer: charlie, follower: bob)
      delete :destroy, id: bob_charlie_relationship.id
      bob.following_relationships.should == [bob_charlie_relationship]
    end

    it "redirects to people path" do
      bob = Fabricate(:user)
      relationship_with_bob = Fabricate(:relationship, influencer: bob, follower: alice)
      delete :destroy, id: relationship_with_bob.id
      response.should redirect_to people_path
    end

    it_behaves_like 'require_sign_in' do
      let(:action) { post :destroy, id: 3 }
    end
  end

  describe "POST create" do
    let(:bob) { Fabricate(:user) }

    it "creates a relationship that the current user follows someone" do
      post :create, influencer_id: bob.id
      Relationship.first.influencer.should == bob
      Relationship.first.follower.should == alice
    end

    it "redirects to the people page" do
      post :create, influencer_id: bob.id
      response.should redirect_to people_path
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create, influencer_id: 4 }
    end
  end
end
