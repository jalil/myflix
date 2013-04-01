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
  category_id 1
  description Faker::Lorem.sentence(1)
  small_image "/assets/images/monk.jpg"
  large_image "/assets/images/monk_lrg.jpg"
end
