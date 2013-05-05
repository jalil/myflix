# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

Fabricator(:line_item) do
  position {1}
  video
  user
end
