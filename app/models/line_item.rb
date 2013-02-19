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

class LineItem < ActiveRecord::Base
  attr_accessible :video_id, :user_id, :position
  validates :video_id, :user_id, :presence => true
  belongs_to :video
  belongs_to :user

end
