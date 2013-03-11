# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string(255)
#  full_name            :string(255)
#  password_digest      :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  password_reset_token :string(255)
#

class User < ActiveRecord::Base
  include Tokenable
  has_many :reviews, :dependent => :destroy
  has_many :videos
  has_many :line_items, order: "position ASC"
  #following
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  #invitations
  belongs_to :invitation
  has_many :sent_invitation, :class_name => 'Invitation', :foreign_key => 'sender_id'

  attr_accessible :password_digest, :email, :full_name, :password, :password_confirmation,:invitation_token
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
end
