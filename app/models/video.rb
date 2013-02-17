# == Schema Information
#
# Table name: videos
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  small_cvr_url :binary
#  lrg_cvr_url   :binary
#  description   :text
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Video < ActiveRecord::Base

  #associations
  belongs_to :category
  belongs_to :user
  has_many :line_items, :order => "position ASC"
  has_many :reviews, :order=> "created_at DESC"

  attr_accessible :category_id, :description, :lrg_cvr_url, :name, :small_cvr_url

  #validations
  validates :name, :small_cvr_url, :lrg_cvr_url, :description,  :presence =>true

  def self.search_by_title(search_term)
	  if search_term.blank?
	         []
	  else
	    where("name LIKE ?", "#{search_term}%")
    end
  end
end
