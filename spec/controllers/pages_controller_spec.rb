require 'spec_helper'

describe PagesController do
    describe "GET 'front'" do
        context "authenticated user" do
          it "redirects to home_path because user already logged in"  do
            bobby = Fabricate(:user)
            set_current_user(bobby)
            get :front
            response.should redirect_to home_path
          end
        end
    end
end
