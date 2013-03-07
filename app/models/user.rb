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
  has_many :reviews, :dependent => :destroy
  has_many :videos
  has_many :line_items, order: "position ASC"
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  #invitations
  belongs_to :invitations

  attr_accessible :password_digest, :email, :full_name, :password, :password_confirmation
  validates :email, :full_name, :password,  :presence =>true
  validates_uniqueness_of :email
  has_secure_password
  
  before_create  do
    generate_token
  end
  
  def has_a_video_in_queue?(video)
    line_items.map(&:video).include?(video)
  end

  def send_password_reset
    generate_token
    save!(validate: false)
    AppMailer.password_reset(self).deliver
  end

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64
    end while User.where(password_reset_token: token).present?
    self.password_reset_token = token
  end
end
