# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  attr_accessible :title
  attr_accessible :created_at
  validates :title, presence:true
  has_many :videos, order: "created_at ASC"

	def recent_videos
		videos.first(6)
	end
end
