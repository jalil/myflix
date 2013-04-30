require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    it "creates a view for video with the right inputs" do
      video = Fabricate(:video)
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      post :create, review: {rating: 4, content: "good video!"}, video_id: video.id

      video.reviews.count.should == 1
      video.reviews.first.rating.should == 4
      video.reviews.first.content.should == "good video!"
    end

    it "sets the user to the current user" do
      video = Fabricate(:video)
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      post :create, review: {rating: 4, content: "good video!"}, video_id: video.id
      video.reviews.first.user.should == alice
    end

    context "validation failure" do
      let(:video) { Fabricate(:video) }

      before do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        post :create, review: {rating: 4, content: ""}, video_id: video.id
      end

      it "does not create a review" do
        video.reviews.count.should == 0
      end

      it "renders the video show template" do
        response.should render_template :show
      end
    end

    context "unauthorized users" do
      it "should not create a review" do
        video = Fabricate(:video)
        post :create, review: {rating: 4, content: "good video!"}, video_id: video.id
        video.reviews.count == 0
      end

      it "should be redirected to sign in page" do
        video = Fabricate(:video)
        post :create, review: {rating: 4, content: "good video!"}, video_id: video.id
        response.should redirect_to sign_in_path
      end
    end
  end
end
