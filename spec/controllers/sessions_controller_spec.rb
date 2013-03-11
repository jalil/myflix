require 'spec_helper'

describe SessionsController do
  describe "GET #new" do
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "valid inputs" do
      it "stores the user id in sesson" do
        bob =  User.create(email: "bob@example.com", password: "password", full_name:  "Bob Hope")
        post :create, {email: "bob@example.com", password: "password"}
        session[:user_id].should == bob.id
      end
      it "redirects to the video path" do
        bob =  User.create(email: "bob@example.com", password: "bob", full_name:  "Bob Hope")
        post :create, {email: "bob@example.com", password: "bob"}
        response.should redirect_to videos_path
      end
    end
    context "Not sufficient validation/input" do
      it "does not create a session" do
        post :create, { password: "bob" }
        session[:user_id].should be_nil
      end
      it "redirects to the login page" do
        post :create, {password: "bob" }
        response.should redirect_to login_path
      end
    end

    context "not authenticable email and password" do
      it "does not create session" do
        bob =  User.create(email: "bob@example.com", password: "bob", full_name:  "Bob Hope")
        post :create, { password: "password", email: "bob@example"}
        session[:user_id].should be_nil
      end
      it "should redirect_to to login page" do
        bob =  User.create(email: "bob@example.com", password: "bob", full_name:  "Bob Hope")
        post :create, { password: "password", email: "bob@example"}
        response.should redirect_to login_path
      end
    end

     describe "DELETE destroy" do
       it "sets session to nil after logout" do
         delete :destroy
        session[:user_id].should be_nil
       end

       it "redirect_to to login path" do
          delete :destroy
          response.should redirect_to login_path
       end
     end
  end
end











