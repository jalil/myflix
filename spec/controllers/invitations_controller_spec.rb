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

    it "should create the invitation" do
      pending
    end
    end
  end
