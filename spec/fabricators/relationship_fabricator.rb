Fabricator(:relationship) do
  influencer { Fabricate(:user) }
  follower { Fabricate(:user) }
end
