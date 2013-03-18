require 'spec_helper'

describe UsersController do
  describe "GET #new" do
   it "sets the @user variable" do
     get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
   end
   it "should render the :new view" do
     get :new
     response.should render_template :new
   end
  end

  describe  "GET #show" do
      let(:valid_user)  { Fabricate(:user) }
      before do 
        set_current_user(valid_user)
        get :show, id: valid_user.id
      end

    it "assigns the requested the user to @user" do
      assigns(:user).should eq valid_user
    end 

    it "should render the :show template" do
      response.should render_template :show
    end

    it "should set the @reviews variable for user" do
      assigns(:reviews).should eq valid_user.reviews
    end

    it "should set the @line_items variable for user" do
      assigns(:line_items).should eq valid_user.line_items
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
     expect{ post :create, user: {full_name: "Bob hope", email: "bob@example.com", password: "bob"}}.to change{User.count}.by(1) 
      end
      it "should redirect to login path" do
        post :create, user: {full_name: "Bob hope", email: "bob@example.com", password: "bob"} 
        response.should redirect_to login_url
      end
    end

    context "with invalid attributes" do
      it "should not save in database" do
     expect{ post :create, user: {}}.to_not change{User.count} 
      end
      it "should render to :new page" do
        post :create, user: { }
       response.should render_template :new 
      end
    end
    end

    describe "PUT #update" do
      let(:valid_user)  { Fabricate(:user) }
      before do 
        set_current_user(valid_user)
      end
      context "with valid inputs" do
        it " should update the database with the new changes" do
          put :update, id: valid_user, user: {email: "bob@example.com", password: "bob", full_name: "Bob hope"}
          valid_user.reload
          valid_user.email.should eq "bob@example.com"
        end

        it "should render :update  action" do
          put :update, id: valid_user, user: {email: "bob@example.com", password: "bob", full_name: "Bob hope"}
          response.should redirect_to videos_url
        end
      end

      context "without valid inputs" do
        it "should not update database with new changes" do
          put :update, id: valid_user, user: {email: "bob@example.com", password:"", full_name: ""}
          valid_user.reload
          valid_user.email.should_not eq "bob@example.com"
        end
        it "should redirect back to update page for proper inputs" do
          put :update, id: valid_user, user: {email: "bob@example.com", password:"", full_name: ""}
          response.should render_template :update
        end
      end
    end
  end
