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

  def user_rating
    review = video.reviews.where(user_id: user.id).first
    review.blank? ? '' : review.rating.to_i
  end

  def self.update_fields(queue_items)
    unless queue_items.blank?
      sorted = queue_items.sort_by { |key, value| value['position'] }
      sorted.each_with_index do |item, index|
        video = self.find(item[0].to_i).video
        user = self.find(item[0].to_i).user
        self.find(item[0].to_i).update_attributes(position: index + 1)
        if item[1]['rating']
          self.update_rating(video, user, item[1]['rating'])
        end
       end
      end
  end


 private
   def self.update_rating(video, user, rating)
         review = Review.where(user_id: user.id, video_id: video.id).first

        if review.blank?
           review = Review.new(user_id: user.id, video_id: video.id, rating: rating.to_i)
           review.save(validate: false)
        else
           review.rating = rating.to_i
           review.save(validate: false)
        end
      end
end
