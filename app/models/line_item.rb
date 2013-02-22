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

  def self.update_queue(queue_items_array,user)
    queue_items_array.sort!{|a,b| a[1]['position']<=>b[1]['position']}
    queue_items_array.each_with_index do |item_key, index|
      item = user.queue_items.find(item_key[0])
      if item
        item.position = index +1
        item.rating = item_key[1]['rating']
        item.save
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
