require 'spec_helper'

describe PasswordResetsController  do

    describe "GET new" do
      context "valid token" do
        before do
           alice = Fabricate(:user)
           alice.update_attribute(:password_reset_token, 'abcdefgqweerty')
        end

        it "renders the :new template" do
          get :new
          response.should render_template :new
        end

        it "sets the @token variable" do
          get :new, password_reset_token: 'abcdefgqweerty'
          assigns(:token).should == 'abcdefgqweerty'
        end
      end
    end
 end







