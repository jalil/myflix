Fabricator(:invitation) do
  recipient_name { Faker::Internet.email }
  recipient_email { Faker::Internet.email }
  message { " Please join this site" }
  sender{ Fabricate(:user) }
end
