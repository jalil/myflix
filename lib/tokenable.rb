module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create do
      self.token = SecureRandom.urlsafe_base64
    end
  end
end
