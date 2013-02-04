class User < ActiveRecord::Base
  attr_accessible :password_digest, :email, :full_name, :password, :password_confirmation
  validates :email, :full_name,  :presence =>true
  has_secure_password
end
