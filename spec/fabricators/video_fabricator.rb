# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  small_image :binary
#  large_image :binary
#  description :text
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  token       :string(255)
#  url         :string(255)
#

Fabricator(:video) do
  name Faker::Name.first_name
  category 
  small_image "small_image.jpg"
  large_image "large_image.jpg"
  token "23455667"
  description Faker::Lorem.sentence(1)
end

Fabricator(:video_created_at_yesterday, from: :video) do
  created_at {1.day.ago }
end
