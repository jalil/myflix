# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  small_cover_url :string(255)
#  large_cover_url :string(255)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :integer
#  url             :string(255)
#

class Video < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title, :description
  has_many :reviews, order: "created_at DESC"

  def self.search_by_title(search_term)
    if search_term.blank?
      []
    else
      where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
    end
  end

  def rating
    reviews.average(:rating).round(1) if reviews.average(:rating)
  end
end
