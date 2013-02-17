require 'spec_helper'

describe VideosController do
    describe 'Get #show' do
      its "assign the requested video to @video" do
        video = Video.create(name:"Monk", description: "Krazy Police",
                             small_cvr_url:"small.jpg", lrg_cvr_url: "large.jpg")
        bob = User.create(full_name: "bob hope", password: "bob", email:"bob@bob.com")
        session[:user_id] = bob.id
        get :show, id: video.id
        assigns(:video).should == video
      end

      it 'renders the :show template' do
        video = Video.create(name:"Monk", description: "Krazy Police",
                             small_cvr_url:"small.jpg", lrg_cvr_url: "large.jpg")
        bob = User.create(full_name: "bob hope", password: "bob", email:"bob@bob.com")
        session[:user_id] = bob.id
        get :show, id: video.id
        response.should render_template :show
      end
    end

  describe "POST #search " do
    it "should set @videos" do
        video = Video.create(name:"monk office", description: "Krazy Police",
                             small_cvr_url:"small.jpg", lrg_cvr_url: "large.jpg")
        bob = User.create(full_name: "bob hope", password: "bob", email:"bob@bob.com")
        session[:user_id] = bob.id
        post :search, search_term: 'monk'
        assigns(:videos).should ==[video]
    end
    it "should render search template" do
        post :search, search_term: 'monk'
        response.should render_template :search
    end
  end
end
