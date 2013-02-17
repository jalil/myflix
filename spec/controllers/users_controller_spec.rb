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

  describe "Post create" do
    it "create user wit proper inputs" do
      post :create,
    user = User.create(email: "abc@abc.com",full_name: "bob abc", password: "sesame')
    User.first.full_name == "bob abc"

    it "invalid  user"
    it "redirect to sign in path"

  end
  
  describe  "GET search" do
    it "should return @user variable " do
      get :search, id: search_term
      user = 
    end
    it "redirect to root path" do
      response.should redirect_to  root_path
    end
  end
end
