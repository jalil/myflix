class Invitation < ActiveRecord::Base
  include Tokenable
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'
  validate :recipient_email, :uniqueness => true

  before_create :generate_token

end


