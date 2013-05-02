# == Schema Information
#
# Table name: invitations
#
#  id              :integer          not null, primary key
#  sender_id       :integer
#  token           :string(255)
#  recipient_email :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recipient_name  :string(255)
#  message         :text
#

class Invitation < ActiveRecord::Base
  include Tokenable
  belongs_to :inviter, :class_name => 'User'
  validates :recipient_name ,  :message, :token, :recipient_email, presence: true

  before_create :generate_token

end


