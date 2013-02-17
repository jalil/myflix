require 'spec_helper'

describe ReviewsController do
  describe "GET 'create' " do
    context "an unauthenticated user" do
      it "should http redirect " do
        get :create
        response.should be_redirect
      end
    end
    context "authenticated user " do
         let(:video)  {Fabricate(:video)}
         let(:bobby)  {Fabricate(:user)}
         let(:valid_params) {{:review =>{video_id: video.id, user_id: bobby.id, rating:1, content: "respect rspec"}}}
         it "should not redirect" do
          get :create, valid_params
          response.should redirect_to video
        end
      end
    end
  end
