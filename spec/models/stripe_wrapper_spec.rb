require 'spec_helper'

describe StripeWrapper::Charge do
  before do
    StripeWrapper.set_api_key = 'sk_test_HbD6LJuQsNFDTEclWoXuBYrU'
  end

  let(:token) { Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: 1,
        exp_year: 2014,
        cvc: 111
      }
    ).id 
  }

  context "with valid credit card" do
    let(:card_number) { "4242424242424242" }

    it "charges the card successfully" do
      response = StripeWrapper::Charge.create(amount: 100, card: token)
      response.should be_successful
    end
  end

  context "with invalid credit card" do
    let(:card_number) { "4000000000000002" }
    let(:response) { StripeWrapper::Charge.create(amount: 100, card: token) }

    it "does not charge the card" do
      response.should_not be_successful
    end

    it "contains an error message" do
      response.error_message.should == "Your card was declined :("
    end
  end
end

