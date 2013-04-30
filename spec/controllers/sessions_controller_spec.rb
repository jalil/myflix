require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "valid input" do
      it "stores the user id in the session" do
        alice = User.create(email: "alice@example.com", password: "password", full_name: "Alice Doe")
        post :create, {email: "alice@example.com", password: "password"}
        session[:user_id].should == alice.id
      end
      it "redirects to the home path" do
        alice = User.create(email: "alice@example.com", password: "password", full_name: "Alice Doe")
        post :create, {email: "alice@example.com", password: "password"}
        response.should redirect_to home_path
      end
    end
    context "Not satisfying validation" do
      it "does not create a session" do
        post :create, { password: "password" }
        session[:user_id].should be_nil
      end
      it "redirects to the sign in path" do
        post :create, { password: "password" }
        response.should redirect_to sign_in_path
      end
    end

    context "not authenticable email and password" do
      it "does not create a session" do
        alice = User.create(email: "alice@example.com", password: "secret", full_name: "Alice Doe")
        post :create, {email: "alice@example.com", password: "password"}
        session[:user_id].should be_nil
      end

      it "redirects to the sign in path" do
        alice = User.create(email: "alice@example.com", password: "secret", full_name: "Alice Doe")
        post :create, {email: "alice@example.com", password: "password"}
        response.should redirect_to sign_in_path
      end
    end
  end
end
