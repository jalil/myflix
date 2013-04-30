require 'spec_helper'

describe QueueItemsController do

  let(:alice) { Fabricate(:user) }
  before { set_current_user(alice) }

  describe "GET index" do
    it "sets @queue_items" do
      item1 = Fabricate(:queue_item)
      item2 = Fabricate(:queue_item)
      alice.queue_items << item1
      alice.queue_items << item2
      get :index
      assigns(:queue_items).should == [item1, item2]
    end

    it "renders the index template" do
      get :index
      response.should render_template :index
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    it "creates a queue item for the current user" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      alice.queue_items.map(&:video).should == [video]
    end

    it "redirects to my queue page" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      response.should redirect_to my_queue_path
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post:create, video_id: 3 }
    end
  end

  describe "DELETE destroy" do
    context "happy path" do
      let(:item1) { Fabricate(:queue_item, user: alice) }
      let(:item2) { Fabricate(:queue_item, user: alice) }

      before do
        delete :destroy, id: item1.id
      end

      it "deletes the queue item from the user's queue" do
        alice.queue_items.should == [item2]
      end

      it "redirects to my queue page" do
        response.should redirect_to my_queue_path
      end
    end

    context "unauthenticated user" do
      it "does not delete the queue item" do
        item = Fabricate(:queue_item)
        delete :destroy, id: item.id
        QueueItem.count.should == 1
      end

      it_behaves_like "require_sign_in" do
        let(:action) { delete :destroy, id: 3 }
      end
    end

    context "unauthorized delete" do
      let(:bob) { Fabricate(:user) }

      before do
        item = Fabricate(:queue_item, user: bob)
        delete :destroy, id: item.id
      end

      it "does not delete the queue item" do
        QueueItem.count.should == 1
      end

      it "redirects to the my queue page" do
        response.should redirect_to my_queue_path
      end
    end
  end

  describe "POST update_queue" do
    let(:item1) { Fabricate(:queue_item, user: alice, position: 1) }
    let(:item2) { Fabricate(:queue_item, user: alice, position: 2) }
    let(:item3) { Fabricate(:queue_item, user: alice, position: 3) }

    it "handles explicit position numbers" do
      post :update_queue, queue_items: {item1.id => {position: 2}, item2.id => {position: 1}}
      alice.queue_items.reload.should == [item2, item1]
      alice.queue_items.reload.map(&:position).should == [1, 2]
    end

    it "handles arbitrary position numbers and reorder them" do
      post :update_queue, queue_items: {item1.id => {position: 4}, item2.id => {position: 2}, item3.id => {position: 3}}
      alice.queue_items.should == [item2, item3, item1]
      alice.queue_items.map(&:position).should == [1, 2, 3]
    end

    it "handles decimal numbers" do
      post :update_queue, queue_items: {item1.id => {position: 2.5}, item2.id => {position: 2}, item3.id => {position: 3}}
      alice.queue_items.reload.should == [item2, item1, item3]
      alice.queue_items.reload.map(&:position).should == [1, 2, 3]
    end

    it "redirects to my queue path" do
      post :update_queue, queue_items: {item1.id => {position: 2.5}, item2.id => {position: 2}, item3.id => {position: 3}}
      response.should redirect_to my_queue_path
    end

    it "does not change position for unauthenticated user" do
      session[:user_id] = nil
      post :update_queue, queue_items: {item1.id => {position: 2.5}, item2.id => {position: 2}, item3.id => {position: 3}}
      alice.queue_items.reload.should == [item1, item2, item3]
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :update_queue, queue_items: {1 => {position: 1} } }
    end

    it "does not change position for unauthorized reorder" do
      bob = Fabricate(:user)
      set_current_user(bob)
      post :update_queue, queue_items: {item1.id => {position: 2.5}, item2.id => {position: 2}, item3.id => {position: 3}}
      alice.queue_items.reload.should == [item1, item2, item3]
    end

    context "with rating" do
      let(:item1) { Fabricate(:queue_item, user: alice) }
      let(:item2) { Fabricate(:queue_item, user: alice) }
      let(:item3) { Fabricate(:queue_item, user: alice) }

      context "with no prior rating" do
        context "no existing reviews" do
          it "does not create a review when user does not select rating" do
            post :update_queue, queue_items: {item1.id => {position: 2.5, rating: ""}, item2.id => {position: 2, rating: ""}, item3.id => {position: 3, rating: ""}}
            Review.count.should == 0
          end

          it "redirects to the my queue path" do
            post :update_queue, queue_items: {item1.id => {position: 2.5, rating: ""}, item2.id => {position: 2, rating: ""}, item3.id => {position: 3, rating: ""}}
            response.should redirect_to my_queue_path
          end
        end

        context "with existing review" do
          it "updates an existing review" do
            review = Fabricate(:review, user: alice, video: item1.video, rating: 2)
            post :update_queue, queue_items: {item1.id => {position: 2.5, rating: 3}, item2.id => {position: 2, rating: ""}, item3.id => {position: 3, rating: ""}}
            review.reload.rating.should == 3
          end
          it "clears an existing review's rating" do
            review = Fabricate(:review, user: alice, video: item1.video, rating: 2)
            post :update_queue, queue_items: {item1.id => {position: 2.5, rating: ""}, item2.id => {position: 2, rating: ""}, item3.id => {position: 3, rating: ""}}
            review.reload.rating.should == nil
          end
        end
      end
    end
  end
end
