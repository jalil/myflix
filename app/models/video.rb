# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  small_image :binary
#  large_image :binary
#  description :text
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  token       :string(255)
#  url         :string(255)
#

class Video < ActiveRecord::Base

  #associations
  belongs_to :category
  belongs_to :user
  has_many :line_items, :order => "position ASC"
  has_many :reviews, :order=> "created_at DESC"

  attr_accessible :url, :category_id, :description, :large_image, :name, :small_image

  #carreierwave
  mount_uploader  :large_image, LargeCoverUploader
  mount_uploader  :small_image, SmallCoverUploader

  before_create :generate_token
  #validations
  validates :name, :small_image, :large_image, :description,  :presence =>true

  def self.search_by_title(search_term)
	  if search_term.blank?
	         []
	  else
      where("name LIKE ?", "#{search_term}%").order("created_at DESC")
      #where("name LIKE ?", "%#{search_term}%").order("created_at DESC")
    end
  end

#  def to_param
 #   token
  #end

  private
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
