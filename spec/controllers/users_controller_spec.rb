require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "should set @user" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end
    it "should render :new" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "with valid user input" do
      after do
        ActionMailer::Base.deliveries.clear
      end

      context "with valid card info" do
        before do
          charge = double('charge', successful?: true)
          StripeWrapper::Charge.stub(:create).and_return(charge)
        end

        it "creates the user" do
          post :create, user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}
          User.first.full_name.should == "Alice Doe"
        end

        it "sends the welcome email" do
          post :create, user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}
          ActionMailer::Base.deliveries.should_not be_empty
          ActionMailer::Base.deliveries.first.to.should == ['alice@example.com']
        end

        it "redirect to sign in path" do
          post :create, user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}
          response.should redirect_to sign_in_path
        end

        it "sets the success flash message" do
          post :create, user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}
          flash[:success].should == "You have successfully signed up. Please sign in."
        end
      end

      context "with invalid card info" do
        before do
          charge = double('charge', successful?: false, error_message: "Your card was declined")
          StripeWrapper::Charge.stub(:create).and_return(charge)
        end

        it "does not create the user" do
          post :create, user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}
          User.count.should == 0
        end
        it "does not send the welcome email" do
          post :create, user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}
          ActionMailer::Base.deliveries.should be_empty
        end
        it "render the sign up template" do
          post :create, user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}
          response.should render_template :new
        end
      end
    end

    context "with invalid user inputs" do
      context "with valid credit card info" do
        before do
          charge = double('charge', successful?: true)
          StripeWrapper::Charge.stub(:create).and_return(charge)
        end

        it "does not create the user" do
          post :create, user: {password: 'sesame', email: "alice@example.com"}
          User.count.should == 0
        end
        it "renders the :new template" do
          post :create, user: {password: 'sesame', email: "alice@example.com"}
          response.should render_template :new
        end

        it "does not charge the card" do
          StripeWrapper::Charge.should_not_receive(:create)
          post :create, user: {password: 'sesame', email: "alice@example.com"}
        end
      end

      context "with invalid credit card info" do
        before do
          charge = double('charge', successful?: false, error_message: "Your card was declined")
          StripeWrapper::Charge.stub(:create).and_return(charge)
        end
        it "does not create the user" do
          post :create, user: {password: 'sesame', email: "alice@example.com"}
          User.count.should == 0
        end
        it "render the :new template" do
          post :create, user: {password: 'sesame', email: "alice@example.com"}
          response.should render_template :new
        end
      end
    end

    context "with invitation token" do
      let(:invitation) { Fabricate(:invitation) }

      context "with valid card info" do
        before do
          charge = double('charge', successful?: true)
          StripeWrapper::Charge.stub(:create).and_return(charge)
          post :create, {user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}, token: invitation.token}
        end

        it "the signed up user and the inviter follow each other" do
          alice = User.where(email: 'alice@example.com').first
          bob = invitation.inviter
          alice.follows?(bob).should be_true
          bob.follows?(alice).should be_true
        end

        it "clears the invitation token" do
          invitation.reload.token.should be_nil
        end
      end

      context "with invalid card info" do
        before do
          charge = double('charge', successful?: false, error_message: "Your card was declined")
          StripeWrapper::Charge.stub(:create).and_return(charge)
          post :create, {user: {full_name: 'Alice Doe', password: 'sesame', email: "alice@example.com"}, token: invitation.token}
        end

        it "does not sign up the user" do
          User.where(email: "alice@example.com").count.should == 0
        end

        it "does not clear the inviation token" do
          invitation.reload.token.should be_present
        end

        it "render :new template" do
          response.should render_template :new
        end
      end

    end
  end

  describe "GET show" do
    let(:bob) { Fabricate(:user) }

    before do
      alice = Fabricate(:user)
      set_current_user(alice)
      get :show, id: bob.id
    end

    it "assigns @user" do
      assigns(:user).should == bob
    end

    it "renders the show template" do
      response.should render_template :show
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: 4 }
    end
  end

  describe "GET new_with_invitation" do
    let(:invitation) { Fabricate(:invitation) }

    context "with valid token" do
      before do
        get :new_with_invitation, token: invitation.token
      end

      it "sets @user with values matching the invitation" do
        assigns(:user).full_name.should == invitation.recipient_name
        assigns(:user).email.should == invitation.recipient_email
      end

      it "render the new template" do
        response.should render_template :new
      end

      it "sets @token of the invitation" do
        assigns(:token).should == invitation.token
      end
    end

    context "with invalid token" do
      it "redirects to invalid token page" do
        get :new_with_invitation, token: 'aasdfasdf'
        response.should redirect_to expired_token_path
      end
    end
  end
end

