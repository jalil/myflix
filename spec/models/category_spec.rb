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
    it { should have_many(:videos) }

    describe "recent videos" do
      it "should return the most recent 6 videos" do
      category = Fabricate(:category)
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        video3 = Fabricate(:video)
        video4 = Fabricate(:video)
        video5 = Fabricate(:video)
        video6 = Fabricate(:video)
        video7 = Fabricate(:video)
        category.recent_videos.should eq [video7,video6,video5,video4,video3,video2]
      end
    end
end

