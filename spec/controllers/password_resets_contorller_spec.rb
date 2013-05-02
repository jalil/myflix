require 'spec_helper'

describe PasswordResetsController do
  describe "GET #new" do
  it "render the new template" do
    get :new
    response.should render_template :new
  end
  end

  describe "POST create"  do
    context "with valid email"  do
    it "redirect to password confirmation page"  do
      response.should redirect_to password_reset_path
    end
    it "sends out email to right person" do
      Fabricate(:user, email: 'jalil@email.com')
    post :create, email: 'bob@example.com'
    ActionMailer::Base.deliveries.should_not be_empty
  end
  end
end
end
