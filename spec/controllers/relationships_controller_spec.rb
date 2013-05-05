require 'spec_helper'

describe RelationshipsController do
  let(:alice) { Fabricate(:user) }
  before { set_current_user(bob) }

  describe "GET index" do
    it 'assign @relationships' do
      bob = Fabricate(:user)
      relationship = Fabricate(:relationships, influencer: bob, follower: alice)
      get :index
      assign(:relationships).should == [relationship]
    end
  end
end
