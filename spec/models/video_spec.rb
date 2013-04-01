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

require "spec_helper"

describe Video do
  describe "associations for Video"  do    
    it { should belong_to(:category) }
  end

  describe " Validate Video" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
  end

  context  "search results for video" do
    before :each  do
      @video_1 =  Fabricate(:video, name: "curb your mom")
      @video_2 =  Fabricate(:video, name: "curb your daddy")
    end

    it  "should return an empty array if search title result is not there" do
      Video.search_by_title("seinfeld").should == []
    end

    it "should return result if its in search" do
      Video.search_by_title("curb").should include(@video_1, @video_2)
    end
   end
end
