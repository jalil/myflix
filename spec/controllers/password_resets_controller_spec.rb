require 'spec_helper'

describe PasswordResetsController do

  describe "GET new" do
    context "valid token" do
      before do
        alice = Fabricate(:user)
        alice.update_attribute(:token, 'abcdefg')
      end

      it "renders :new template" do
        get :new, token: 'abcdefg'
        response.should render_template :new
      end

      it "sets the @token variable" do
        get :new, token: 'abcdefg'
        assigns(:token).should == 'abcdefg'
      end
    end

    context "invalid token" do
      it "redirects to invalid token page" do
        get :new, token: 'abcdefg'
        response.should redirect_to expired_token_path
      end
    end
  end

  describe "POST create" do
    context 'with valid token' do
      it "updates the user's password" do
        alice = Fabricate(:user, password: 'old_password')
        post :create, token: alice.token, password: 'new_password'
        alice.reload.authenticate('new_password').should be_true
      end

      it "clears up the user token" do
        alice = Fabricate(:user, password: 'old_password')
        post :create, token: alice.token, password: 'new_password'
        alice.reload.token.should be_nil
      end

      it 'redirect to the sign in path' do
        alice = Fabricate(:user, token: 'abcde', password: 'old_password')
        post :create, token: alice.token, password: 'new_password'
        response.should redirect_to sign_in_path
      end
    end

    context 'with invalid token' do
      it 'redirects to the invalid token page' do
        post :create, token: 'asdf', password: 'new_password'
        response.should redirect_to expired_token_path
      end

      it 'does not update any users password' do
        alice = Fabricate(:user, token: 'abcde', password: 'old_password')
        post :create, token: 'asdlfui', password: 'new_password'
        alice.reload.authenticate('old_password').should be_true
      end
    end
  end
end
