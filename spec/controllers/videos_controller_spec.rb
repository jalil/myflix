require 'spec_helper'

describe VideosController do
  let(:alice) { Fabricate(:user) }
  before { set_current_user(alice) }

    describe 'Get #show' do

      let(:vid) { Fabricate(:video) }
      
      before do 
        get :show, id: vid.id
      end

      it "should set @video" do 
        assigns(:video).should == vid 
      end

      it "should render the show template" do 
        response.should render_template :show
      end
      
      it "set the @reviews" do 
        review =vid.reviews.create(rating: 3, user_id: alice.id, comment: " Awesome video")
        assigns(:reviews).should ==[ review]
      end
  end

    describe "POST #search"  do
      it "should set @videos" do
         vid = Video.create(name: 'monk of shaolin', description: "Policia show about")
         post :search, search_term: 'monk'
         assigns(:videos).should == [vid]
      end

       it "should render the search template" do
          post :search, search_term: 'super'
          response.should render_template :search
        end

       it_behaves_like "require_sign_in" do
         let(:action) { post :search, search_term: 'abc' }
       end
     end
end
