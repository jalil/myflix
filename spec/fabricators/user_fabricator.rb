# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  full_name              :string(255)
#  password_digest        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_reset_token   :string(255)
#  invitation_id          :integer
#  invitation_limit       :integer
#  admin                  :boolean
#  password_reset_sent_at :datetime
#

Fabricator(:user) do
  email     { Faker::Internet.email }
  full_name { Faker::Name.name }
  password  {Faker::Lorem.characters(5) }
  admin     {false }
end

Fabricator(:admin, from: :user) do
  admin {true}
end
