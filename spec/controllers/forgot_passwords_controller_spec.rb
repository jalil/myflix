require 'spec_helper'

describe ForgotPasswordsController do
  describe "GET new" do
    it "renders the forgot password template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "with valid email" do
      after do
        ActionMailer::Base.deliveries = []
      end

      it "redirects to password reset confirmation" do
        Fabricate(:user, email: 'joe@example.com')
        post :create, email: 'joe@example.com'
        response.should redirect_to reset_password_confirmation_path
      end

      it "sends out an email to the email provided" do
        Fabricate(:user, email: 'joe@example.com')
        post :create, email: 'joe@example.com'
        ActionMailer::Base.deliveries.should_not be_empty
      end

      it "sends out an email to the email provided" do
        Fabricate(:user, email: 'joe@example.com')
        post :create, email: 'joe@example.com'
        ActionMailer::Base.deliveries.first.to.should == ['joe@example.com']
      end
    end

    context "with email not in system" do
      it "does not send out emails" do
        post :create, email: 'joe@example.com'
        ActionMailer::Base.deliveries.should be_empty
      end

      it "redirects to password reset page" do
        post :create, email: 'joe@example.com'
        response.should redirect_to forgot_password_path
      end
    end
  end
end
