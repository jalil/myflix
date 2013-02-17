Fabricator(:review) do
  video_id {Random.rand(2)}
  user_id  {Random.rand(2)}
  rating   {Random.rand(3)}
  comment "respect rspec"
end
