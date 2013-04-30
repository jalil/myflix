Fabricator(:invitation) do
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.email }
  message { "Hello pleae join" }
  inviter { Fabricate(:user) }
end
