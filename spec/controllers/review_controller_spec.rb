require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    it "creates a view for a video with the right inputs" do
      video = Fabricate(:video)
      bob = Fabricate(:user)
      session[:user_id ] = bob.id 
     post :create, review: { rating: 1, comment: "this show sucks!"}, video_id: video.id 

     video.reviews.count.should == 1
     video.reviews.first.rating.should == 1
     video.reviews.first.comment.should == "this show sucks!"
    end

    it "set the user to the current user" do
      video = Fabricate(:video)
      bob = Fabricate(:user)
      session[:user_id ] = bob.id 
      post :create, review: { rating: 1, comment: "this show sucks!"}, video_id: video.id 
      video.reviews.first.user.should == bob
    end

    context "validation failure of review" do
      let(:video) { Fabricate(:video)}

      before do
        bob =  Fabricate(:user)
        session[:user_id] = bob.id
        post :create, review: { rating: 2, comment: ""}, video_id: video.id
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
        post :create, review: { rating: 2, comment: " so so rating"}, video_id: video.id
        video.reviews.count == 0
      end
    end
  end
end
