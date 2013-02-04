require 'spec_helper'

describe UsersController do
  describe "set the @users variable" do
   it "sets the @user variable" do
     get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
   end
   it "renders the new template" do
     get :new
     response.should render_template :new
   end
  end
end
