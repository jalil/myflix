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

  def self.update_queue(queue_items)
    unless queue_items.blank?
      sorted = queue_items.sort_by { |key, value| value['position'] }
        require pry; binding.pry
      sorted.each_with_index do |item, index|
        video = self.find(item[0].to_i).video
        user = self.find(item[0].to_i).user
        self.find(item[0].to_i).update_attributes(position: index + 1)
      end
    end
  end

  def rating
    review = video.reviews.where(user_id: user.id).first
    if review
      review.rating
    else
      5
    end
  end

  def rating=(rating_value)
    review= video.reviews.where(user_id: user.id).first_or_create
    review.rating_value
  end
end
