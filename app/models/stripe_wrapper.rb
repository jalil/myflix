module StripeWrapper
  class Charge
    attr_reader :response, :error_message

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      begin
        set_api_key
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: options[:currency],
          card: options[:card],
          description: options[:description]
        )
        new(response: response)
      rescue Stripe::CardError => e
        new(response: nil, error_message: e.message)
      end
    end

    def successful?
      response
    end

    def amount
      response.amount
    end

    private

    def self.set_api_key
      Stripe.api_key = Rails.env.production? ? ENV['stripe_live_api_key'] : 'sk_test_HbD6LJuQsNFDTEclWoXuBYrU' 
    end
  end
end
