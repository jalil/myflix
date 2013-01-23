class Video < ActiveRecord::Base
  belongs_to :category
  attr_accessible :category_id, :description, :lrg_cvr_url, :name, :small_cvr_url
end
