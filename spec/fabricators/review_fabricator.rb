# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  comment    :text
#  video_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:review) do
  video_id {Random.rand(2)}
  user_id  {Random.rand(2)}
  rating   {Random.rand(3)}
  comment "respect rspec"
end
