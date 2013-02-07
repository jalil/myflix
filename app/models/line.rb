# == Schema Information
#
# Table name: lines
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  video_id   :integer
#

class Line < ActiveRecord::Base
  attr_accessible :video_id, :user_id
  has_many :videos
  belongs_to :user
end
