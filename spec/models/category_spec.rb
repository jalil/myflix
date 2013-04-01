# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "spec_helper"

describe Category do
  describe "association" do
    it {should have_many(:videos)}
  end

  describe "validation of model" do
    it { should validate_presence_of(:title)}
  end

  describe "recent videos" do
    it "should display 6 of the most recent videos in reverse order" do
      category = Category.new(:title => "Drama")

      video1 = Video.create(name: "video 1", description: " video 1 description and shit" )
      category.videos << video1
      video2 = Video.create(name: "video 2", description: " video 2 description and shit" )
      category.videos << video2
      video3 = Video.create(name: "video 3", description: " video 3 description and shit" )
      category.videos << video3
      video4 = Video.create(name: "video 4", description: " video 4 description and shit" )
      category.videos << video4
      video5 = Video.create(name: "video 5", description: " video 5 description and shit" )
      category.videos << video5
      video6 = Video.create(name: "video 6", description: " video 6 description and shit" )
      category.videos << video6
      video7 = Video.create(name: "video 7", description: " video 7 description and shit" )
      category.videos << video7
      category.save
      category.recent_videos.first.should == [video6]
      end
   end
end

