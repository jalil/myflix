# == Schema Information
#
# Table title: categories
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
      category = Category.create(:title => "Drama")

      video1 = Video.create(name: "video 1", description: " video 1 description and shit" )
      category.videos.append(video1)
      video2 = Video.create(name: "video 2", description: " video 2 description and shit" )
      category.videos.append(video2)
      video3 = Video.create(name: "video 3", description: " video 3 description and shit" )
      category.videos.append(video3)
      video4 = Video.create(name: "video 4", description: " video 4 description and shit" )
      category.videos.append(video4)
      video5 = Video.create(name: "video 5", description: " video 5 description and shit" )
      category.videos.append(video5)
      video6 = Video.create(name: "video 6", description: " video 6 description and shit" )
      category.videos.append(video6)
      video7 = Video.create(name: "video 7", description: " video 7 description and shit" )
      category.videos.append(video7)
      category.recent_videos.should == [video7, video6, video5, video4, video3, video2 ]
      end
   end
end

