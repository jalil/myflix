require 'spec_helper'

describe InvitationsController do

  let(:user) { Fabricate(:user) }
  before { set_current_user(user) }

  describe "GET #new" do
    it  "it should render the new template" do
      get :new
      response.should render_template :new
    end

    it "should assign @invitation variable" do
      get :new
      assigns(:invitation).should be_new_record
      assigns(:invitation).should be_instance_of(Invitation)
    end
  end


  describe "POST #create" do
    context "invitation is saved" do
      before(:each) do
         post :create, invitation: { token: "qwerty1234", recipient_name: "jalil Example", recipient_email: "jalil@example.me", message: "Check out this site!" }              
      end
      after do
        ActionMailer::Base.deliveries.clear
      end
    it "should create the invitation" do
     Invitation.last.recipient_name.should == "jalil Example"
     Invitation.last.recipient_email.should == "jalil@example.me"
     Invitation.last.message.should == "Check out this site!"
     Invitation.last.sender.should == user
    end
    it "should have a token" do
      Invitation.last.token.should_not be_nil
    end
    
    it "redirects user to new_invitation_path" do
        response.should redirect_to videos_path
    end
   end

    context "sending mail" do
      before(:each) do
         post :create, invitation: { token: "qwerty1234", recipient_name: "jalil Example", recipient_email: "jalil@example.me", message: "Check out this site!" }              
      end

      after do
         ActionMailer::Base.deliveries.clear
      end
      it "sends out the email" do
        ActionMailer::Base.deliveries.should_not be_empty
      end

       it "sends the email to the right recipient" do
         ActionMailer::Base.deliveries.last == ['jalil@example.me']
       end
       end

    context "invitation is not saved" do
      before(:each) do
        post :create, invitation: { recipient_name: "", recipient_email: "", message: "" }
      end

      it "does not create the invitation" do
          Invitation.all.count.should == 0
     end

      it "renders the createtemplate" do
        response.should render_template :create
      end
    end
  end
end
    
