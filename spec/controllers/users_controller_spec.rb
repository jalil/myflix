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
    user.first.full_name == "bob abc"

    it "invalid  user"
    it "redirect to sign in path"

  end
  
    end
  end
end
