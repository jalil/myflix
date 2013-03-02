require 'spec_helper'

describe LineItemsController do

    let(:bob) { Fabricate(:user)}
    before { set_current_user(bob) }

  describe 'GET #index' do
      it 'assigns @queue_items' do
        item1 =  Fabricate(:line_item)
        item2 =  Fabricate(:line_item)
        bob.line_items << item1
        bob.line_items << item2
        get :index
        bob.line_items.should == [item1, item2 ]
      end

        it_behaves_like "render_template" do
          let(:action) { get :index }
          let(:template) {:index}
        end

        it_behaves_like "require_sign_in" do
          let(:action) { get :index}
        end
        end

  describe "POST create" do 
    it "create a queue item" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      bob.line_items.map(&:video).should == [video]
    end

    it "redirects to my queue page" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      response.should redirect_to my_queue_path
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create , video_id: 4}
    end
   end

  describe "DELETE destroy" do
    context "authorized user " do
      let(:item1) { Fabricate(:line_item, user:bob) }
      let(:item2) { Fabricate(:line_item, user:bob) }

      before { delete :destroy, id: item1.id }

      it "delete users queue items" do
        bob.line_items.should == [item2]
      end

      its "redirect_to my queue page" do
        response.should redirect_to my_queue_path
      end
    end

    context "unauthorized user" do 
      it "does not delete the items" do 
        item = Fabricate(:line_item)
        delete :destroy,  id: item.id
        LineItem.count.should == 1
      end

      it_behaves_like "require_sign_in" do
        let(:action) { delete :destroy, id:3}
      end
    end

    context "unauthorized delete" do 
      let(:bob) { Fabricate(:user)}

      before do
        item = Fabricate(:line_item,  user: bob)
        delete :destroy, id: item.id
      end

      it "does not delete item in queue item" do
        LineItem.count.should == 1
      end

      it "redirects to my queue page " do
        response.should redirect_to my_queue_path
      end
    end
  end
end

