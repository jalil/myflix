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

Fabricator(:user) do
  email     { Faker::Internet.email }
  full_name { Faker::Name.name }
  password  {Faker::Lorem.characters(5) }
end
