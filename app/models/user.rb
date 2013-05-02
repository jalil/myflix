# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  full_name              :string(255)
#  password_digest        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_reset_token   :string(255)
#  invitation_id          :integer
#  invitation_limit       :integer
#  admin                  :boolean
#  password_reset_sent_at :datetime
#

class User < ActiveRecord::Base
  include Tokenable
  has_many :reviews, :dependent => :destroy
  has_many :videos
  has_many :line_items, order: "position ASC"

  #following
  has_many :following_relationships, class_name: "Relationship", foreign_key: 'follower_id'
  has_many :influencing_relationships, class_name: "Relationship", foreign_key: 'influencer_id'

  #invitations
  belongs_to :invitation
  has_many :sent_invitation, :class_name => 'Invitation', :foreign_key => 'sender_id'

  attr_accessible :password_digest, :email, :full_name, :password, :password_confirmation,:invitation_token, :admin
  validates :email, :full_name, :password,  :presence =>true
  validates_uniqueness_of :email
  has_secure_password
  
  before_create  do
    generate_password_token
  end
  
  def has_a_video_in_queue?(video)
    line_items.map(&:video).include?(video)
  end

  def send_password_reset
    generate_token
    save!(validate: false)
    AppMailer.password_reset(self).deliver
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  def generate_and_store_password_token
    generate_password_token
    self.password_reset_sent_at = Time.zone.now
    self.save!(validate: false)
  end

  def token_expired?
    self.password_reset_sent_at < 1.minutes.ago
  end

  def clear_password_reset_token
    self.password_reset_token = nil
  end
end
