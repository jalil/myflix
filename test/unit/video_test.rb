# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  small_image :binary
#  large_image :binary
#  description :text
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  token       :string(255)
#  url         :string(255)
#

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
