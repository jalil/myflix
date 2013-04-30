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

Fabricator(:user) do
  full_name { Faker::Name.name }
  password { "asdfasdf" }
  email { Faker::Internet.email }
  admin { false }
end

Fabricator(:admin, from: :user) do
  admin { true }
end
