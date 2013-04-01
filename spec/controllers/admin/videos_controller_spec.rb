require 'spec_helper'

describe Admin::VideosController do
  describe "GET #new" do

    let(:bob) {  Fabricate(:admin)}
     context "admins user" do
   
      before(:each) do 
        set_current_user(bob) 
        get :new
      end

    it "assigns the @video to a new video" do
      assigns(:video).should be_new_record
      assigns(:video).should be_instance_of(Video)
    end

    it "should render the :new template" do
     response.should render_template :new
   end
  end

   context "non admin" do
        let(:bob) {  Fabricate(:user)}

         before(:each) do 
            set_current_user(bob) 
            get :new
          end

         it "should redirect to home page" do
          pending
       end
    end
end
  
  describe "GET #index" do
       context "Admin user" do
         it " sets the @video variable" do
       end
     end
  end
end
