# == Schema Information
#
# Table name: videos
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  small_cvr_url :binary
#  lrg_cvr_url   :binary
#  description   :text
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

Fabricator(:video) do
  name Faker::Name.first_name
  category_id 1
  description Faker::Lorem.sentence(1)
  small_cvr_url "/assets/images/monk.jpg"
  lrg_cvr_url "/assets/images/monk_lrg.jpg"
end
