require 'spec_helper'

describe  LineItemsController  do

  describe "GET 'index'" do
    context "autheticated user" do
      let(:user)  {Fabricate(:user)}
      it "renders the 'index' action" do
        session[:user_id] = user.id
        get :index
        response.should render_template :index
      end

      it "assigns the line_item item" do
        item1 =  Fabricate(:line_item)
        item2 =  Fabricate(:line_item)
        bobby =  user
        session[:user_id] = bobby.id
        bobby.line_items << item1
        bobby.line_items << item2
        get :index
        assigns(:line_items).should == [item1, item2]
      end

      it "render the 'index' template'" do
      session[:user_id] = user.id
      get :index
      response.should render_template :index
    end
    end
      context "unauthenticated user" do
        it "should redirect " do
          get :index
          response.should be_redirect
        end
      end
  end
  describe "GET 'create'" do
    it "creates a new line_item" do
      bobby = Fabricate(:user)
      session[:user_id] = bobby.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      bobby.line_items.map(&:video).should == [video]
    end
    it "redirects to my_queue_path" do
      bobby = Fabricate(:user)
      session[:user_id] = bobby.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      response.should redirect_to my_queue_path 
    end
  end
  describe "GET 'destroy' " do
    it "should delete and line_item" do
      bobby = Fabricate(:user)
      video = Fabricate(:video)
      session[:user_id] = bobby.id
      line_item =  Fabricate(:line_item)
      delete :destroy, id: line_item.id
      response.should nil
    end
    it "should redirect to my_queue_path" do
      bobby = Fabricate(:user)
      session[:user_id] = bobby.id
      line_item =  Fabricate(:line_item)
      get :destroy, id: line_item.id
      response.should redirect_to my_queue_path
    end
  end
  end

describe "POST update_line" do
      bob = Fabricate(:user)
    item1 =  Fabricate(:line_item, user: bob, position: 1)
    item2 =  Fabricate(:line_item, user: bob, position: 2)
   before do
     session[:user_id] = bob.id
   end 
  it "position number"  do
    post :update_line, line_items: {item1.id=> {position: 2},
                                         item2.id => {position: 1 }}
    bob.line_items.reload.should == [item2, item1]
    bob.line_items.reload.map(&:position).should == [1, 2]
  end
end
