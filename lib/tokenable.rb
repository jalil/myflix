module Tokenable
  extend ActiveSupport::Concern

  def  generate_password_token
    begin
      token = SecureRandom.urlsafe_base64
    end while User.where(password_reset_token:token).present?
    self.password_reset_token = token
  end


  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end
end
