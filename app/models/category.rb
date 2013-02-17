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
  has_many :videos

	def recent_videos
		videos.order("created_at  DESC").limit(6)
	end
end
