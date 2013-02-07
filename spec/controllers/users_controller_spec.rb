require 'spec_helper'

describe UsersController do
  describe "GET #new" do
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
  
  describe  "GET show" do
    it "should show  @user" do
      user = User.create(email: "abc@abc.com", full_name: "abc bob", password: "bob")
      get :show id: user.id
      assigns(:user).should == user
    end
  end
end
