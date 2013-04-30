# == Schema Information
#
# Table name: relationships
#
#  id            :integer          not null, primary key
#  influencer_id :integer
#  follower_id   :integer
#

class Relationship < ActiveRecord::Base
  belongs_to :influencer, class_name: "User"
  belongs_to :follower, class_name: "User"
end
