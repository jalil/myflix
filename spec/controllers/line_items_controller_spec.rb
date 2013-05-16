require 'spec_helper'

describe LineItemsController do
  describe "GET index" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }

    before(:each) do
      set_current_user(user)
      get :index
    end

    it "should set the @line_item variable" do
      line_item = LineItem.create(user_id: session[:user_id], video_id: video.id)
      assigns(:line_items).should == [line_item]
    end

    it "should render the index template" do
      response.should render_template :index
    end

    let(:user1) { Fabricate(:user) }
    let(:user2) { Fabricate(:user) }
    let(:video1) { Fabricate(:video) }
    let(:line_item1) { Fabricate(:line_item, user: user1, video: video1) }
    let(:line_item2) { Fabricate(:line_item, user: user2, video: video1) }

    it "should only show line items for current user" do
      LineItem.find_all_by_user_id(session[:user_id]).should_not include(line_item2)
    end
  end

  describe "POST create" do
    it "should add movie to line" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      session[:user_id] = user.id
      line_item = LineItem.create(user_id: user.id, video_id: video.id)
      post :create, { video_id: 1, user_id: 1 }
      LineItem.all.count.should == 2
    end
  end

  describe "DELETE destroy" do
    context "when user is logged in" do

      let(:user) { Fabricate(:user) }
      let(:line_item) { Fabricate(:line_item, user: user) }

      before(:each) do
        set_current_user(user)
        delete :destroy, id: line_item.id
      end

      it "should not have the line item" do
        LineItem.all.should_not include(line_item)
      end

      it "should redirect to my_queue_path" do
        response.should redirect_to videos_path
      end
    end
  end

  describe "POST #update_line" do
    let(:user) { Fabricate(:user) }
    let(:line_item1) { Fabricate(:line_item, user: current_user, position: 1) }
    let(:line_item2) { Fabricate(:line_item, user: current_user, position: 2) }
    let(:line_item3) { Fabricate(:line_item, user: current_user, position: 3) }

    before(:each) do
      set_current_user(user)
    end

    it "sorts line items by position" do
      post :update_line, line_items: { line_item1.id => { position: 3 }, line_item2.id => { position: 1 }, line_item3.id => { position: 2 } }

      current_user.line_items.reload.should == [line_item2, line_item3, line_item1]
      current_user.line_items.reload.map(&:position).should == [1, 2, 3]
    end

    it "sorts line items by position with decimals" do
      post :update_line, line_items: { line_item1.id => { position: 1.5 }, line_item2.id => { position: 1 }, line_item3.id => { position: 2 } }

      current_user.line_items.reload.should == [line_item2, line_item1, line_item3]
      current_user.line_items.reload.map(&:position).should == [1, 2, 3]
    end

    it "redirects to my_line" do
      post :update_line, line_items: { line_item1.id => { position: 1.5 }, line_item2.id => { position: 1 }, line_item3.id => { position: 2 } }
      response.should redirect_to my_queue_path
    end

    it "updates existing video rating" do
      video = Fabricate(:video)
      review = Fabricate(:review, video: video, user: current_user)
      post :update_line, line_items: { line_item1.id => { position: 1, rating: 1 } }

      current_user.line_items.reload.first.video.reviews.where(user_id: current_user.id).first.rating.should == 1
    end

    it "creates new review with rating when rating does not exist" do
      video = Fabricate(:video)
      post :update_line, line_items: { line_item1.id => { position: 1, rating: 2 } }

      Review.where(user_id: current_user.id).count.should == 1
      Review.where(user_id: current_user.id).first.rating.should == 2
    end
  end
end
