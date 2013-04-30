# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  include Tokenable

  validates_presence_of :full_name, :password, :email
  validates_uniqueness_of :email

  has_secure_password
  has_many :queue_items, order: :position
  has_many :reviews

  has_many :following_relationships, class_name: "Relationship", foreign_key: 'follower_id'
  has_many :influencing_relationships, class_name: "Relationship", foreign_key: 'influencer_id'

  def has_video_in_queue?(video)
    videos_in_queue.include?(video)
  end

  def videos_in_queue
    queue_items.map(&:video)
  end

  def follow(a_user)
    self.following_relationships.create(influencer: a_user) unless self == a_user || self.follows?(a_user)
  end

  def follows?(a_user)
    Relationship.where(influencer_id: a_user.id, follower_id: self.id).any?
  end
end
