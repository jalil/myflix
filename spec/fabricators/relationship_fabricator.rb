# == Schema Information
#
# Table name: relationships
#
#  id            :integer          not null, primary key
#  influencer_id :integer
#  follower_id   :integer
#

Fabricator(:relationship) do
  influencer { Fabricate(:user) }
  follower { Fabricate(:user) }
end
