# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  small_cover_url :string(255)
#  large_cover_url :string(255)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :integer
#  url             :string(255)
#

Fabricator(:video) do
  title { Faker::Lorem.words(5) }
  description { Faker::Lorem.paragraph(3) }
  category
end

Fabricator(:video_created_at_yesterday, from: :video) do
  created_at { 1.day.ago }
end
