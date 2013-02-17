# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  full_name       :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :reviews, :dependent => :destroy
  has_many :videos
  has_many :line_items, order: "position ASC"

  attr_accessible :password_digest, :email, :full_name, :password, :password_confirmation
  validates :email, :full_name,  :presence =>true
  validates_uniqueness_of :email
  has_secure_password

  def has_a_video_in_queue?(video)
    queue_items.map(&:video).include?(video)
  end
end
