# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  comment    :text
#  video_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ActiveRecord::Base
  attr_accessible :comment, :rating, :video_id, :user_id
  #validations
  validates  :rating ,presence: true
  validates  :comment ,presence: true
  #associations
  belongs_to :video
  belongs_to :user
end
