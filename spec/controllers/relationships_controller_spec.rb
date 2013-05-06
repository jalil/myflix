require 'spec_helper'

describe RelationshipsController do
  let(:alice) { Fabricate(:user) }
  before { set_current_user(alice) }

  describe "GET index" do
    it 'assign @relationships' do
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, influencer: bob, follower: alice)
      get :index
      assigns(:relationships).should == [relationship]
    end

    it "renders the :index action" do
      get :index
      response.should render_template :index
    end

    it_behaves_like 'require_sign_in' do
      let(:action){ get :index }
    end
  end

  describe "DELETE destroy" do
    it "destroys that relationship" do
      bob = Fabricate(:user)
      jack = Fabricate(:user)

      relationship_with_bob  = Fabricate(:relationship, influencer: bob, follower: alice)
      relationship_with_jack = Fabricate(:relationship, influencer: jack, follower: alice)
      delete :destroy, id: relationship_with_bob.id
      alice.following_relationships.should == [relationship_with_jack]
  end

     it "cannot destroy relationship that the current user is not a follower" do
        bob = Fabricate(:user)
        jack = Fabricate(:user)
        bob_jack_relationship = Fabricate(:relationship, influencer: jack, follower: bob)
        delete :destroy, id: bob_jack_relationship.id
        bob.following_relationships.should == [bob_jack_relationship]
     end

     it "redirects to the people page" do
       post :create, influencer_id: bob.id
       response.should redirect_to people_path
     end
end
end
