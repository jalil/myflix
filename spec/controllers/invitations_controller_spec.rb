require 'spec_helper'

describe InvitationsController do
  let(:alice) { Fabricate(:user) }
  before { set_current_user(alice) }

  describe "GET new" do
    it "sets @invitation to a new invitation" do
      get :new
      assigns(:invitation).should be_new_record
    end

    it "renders the new template" do
      get :new
      response.should render_template :new
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do

    it_behaves_like "require_sign_in" do
      let(:action) do 
        post :create, invitation: {recipient_name: 'Bob Hope', recipient_email: 'bob@example.com', message: 'Hi Join this site!'}
      end
    end

    context "valid input" do
      before do
        post :create, invitation: {recipient_name: 'Bob Hope', recipient_email: 'bob@example.com', message: 'Hi Join this site!'}
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "creates an invitation" do
        invitation = Invitation.first
        invitation.recipient_name.should == 'Bob Hope'
        invitation.recipient_email.should == 'bob@example.com'
        invitation.message.should == 'Hi Join this site!'
        invitation.inviter.should == alice
      end

      it "sends out an email to the invited person" do
        invitation = Invitation.first
        ActionMailer::Base.deliveries.last.to.should == ['bob@example.com']
        ActionMailer::Base.deliveries.last.body.should include('Hi Join this site!')
        ActionMailer::Base.deliveries.last.body.should include('Bob Hope')
        ActionMailer::Base.deliveries.last.body.should include(invitation.token)
        ActionMailer::Base.deliveries.last.body.should include(alice.full_name)
      end

      it "redirects to the invitation page" do
        response.should redirect_to new_invitation_path
      end
    end

    context "invalid input" do
      before do
        post :create, invitation: {recipient_email: 'bob@example.com', message: 'Hi Join this site!'}
      end

      it "does not create an invitation for invalid input" do
        Invitation.count.should == 0
      end

      it "renders the new template" do
        response.should render_template :new
      end

      it "does not send an email for invalid input" do
        ActionMailer::Base.deliveries.should be_empty
      end
    end
  end
end
