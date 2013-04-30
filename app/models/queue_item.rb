# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  def rating
    review.rating if review
  end

  def rating=(number)
    if review
      number.blank? ? review.rating = nil : review.rating = number
      review.save
    else
      Review.new(user: user, video: video, rating: number).save(validate: false) unless number.blank?
    end
  end

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end
end
