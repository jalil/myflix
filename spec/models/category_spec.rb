# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe "recent_videos" do
    it "returns an empty array where no videos in category" do
      comedies = Category.create(name: "comedies")
      comedies.recent_videos.should == []
    end

    it "returns one video in category" do
      comedies = Category.create(name: "comedies")
      south_park = comedies.videos.create(title: "South Park", description: "soemting")
      comedies.recent_videos.should == [south_park]
    end

    it "returns multiple videos in category in reverse chronically order" do
      comedies = Category.create(name: "comedies")
      futurama = comedies.videos.create(title: "Futurama", created_at: 1.day.ago, description: "soemting")
      south_park = comedies.videos.create(title: "South Park", description: "soemting")
      comedies.recent_videos.should == [south_park, futurama]
    end

    it "returns up to 6 videos when there are more in category" do
      comedies = Category.create(name: "comedies")
      family_guy = comedies.videos.create(title: "Family Guy", description: "Hey ya")
      10.times { comedies.videos.create(title: "somehting", description: "some description", created_at: 1.day.ago) }
      comedies.recent_videos.count.should == 6
      comedies.recent_videos.first.should == family_guy
    end
  end
end
