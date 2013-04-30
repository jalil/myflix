require 'spec_helper'

describe StripeWrapper::Charge do

  let(:token) do
    Stripe.api_key = 'sk_test_HbD6LJuQsNFDTEclWoXuBYrU'
    Stripe::Token.create(
      :card => {
        :number => "4242424242424242",
        :exp_month => 4,
        :exp_year => 2014,
        :cvc => 234
      },
    ).id
  end

  it "passes through the call the stripe api" do
    response = StripeWrapper::Charge.create(:amount => 1000, :currency => "usd", :card => token, :description => "bob@example.com")
    response.amount.should == 1000
  end

  context "with valid card info" do
    it "returns a successful charge response" do
      response = StripeWrapper::Charge.create(:amount => 1000, :currency => "usd", :card => token, :description => "bob@example.com")
      response.should be_successful
    end
  end

  context "with invalid card info" do
    let(:token) do
      Stripe.api_key = 'sk_test_HbD6LJuQsNFDTEclWoXuBYrU'
      Stripe::Token.create(
        :card => {
          :number => "4000000000000002",
          :exp_month => 4,
          :exp_year => 2014,
          :cvc => 123
        },
      ).id
    end
    it "returns a failed charge response" do
      response = StripeWrapper::Charge.create(:amount => 1000, :currency => "usd", :card => token, :description => "bob@example.com")
      response.should_not be_successful
    end

    it "tells the error message" do
      response = StripeWrapper::Charge.create(:amount => 1000, :currency => "usd", :card => token, :description => "bob@example.com")
      response.error_message.should == "Your card was rejected!"
    end
  end
end
