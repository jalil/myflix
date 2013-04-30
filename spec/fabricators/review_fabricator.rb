# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  video_id   :integer
#  content    :text
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:review) do
  user
  video
  content { Faker::Lorem.words(40) }
end
