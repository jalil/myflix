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

require "spec_helper"

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order("created_at DESC") }

  let(:video) { Fabricate(:video) }

  describe "search_by_title" do
    it "returns an empty array if there's no match" do
      monk = Video.create(title: "Monk", description: 'hello')
      Video.search_by_title("something").should == []
    end

    it "returns results if there is match" do
      futurama = Video.create(title: "Futurama", description: 'hello')
      monk = Video.create(title: "Monk", description: 'hello')
      Video.search_by_title("on").should == [monk]
    end

    it "the results should be in the descending order of created_at" do
      monk = Video.create(title: "Monk", description: 'hello', created_at: 1.day.ago)
      bond = Video.create(title: "Bond", description: 'hello')
      Video.search_by_title("on").should == [bond, monk]
    end

    it "returns an empty array is the search term is blank" do
      bond = Video.create(title: "Bond", description: 'hello')
      Video.search_by_title("").should == []
    end
  end

  describe "#rating" do
    let(:video) { Fabricate(:video) }

    it "gives rating nil without reviews" do
      video.rating.should be_nil
    end

    it "gives average rating of one review" do
      video.reviews.create(rating: 4, content: "asd")
      video.rating.should == 4
    end

    it "gives average rating of reviews" do
      video.reviews.create(rating: 4, content: "asd")
      video.reviews.create(rating: 1, content: "asd")
      video.rating.should == 2.5
    end

    it "gives average rating of reviews considering decimals" do
      video.reviews.create(rating: 4, content: "asd")
      video.reviews.create(rating: 1, content: "asd")
      video.reviews.create(rating: 5, content: "asd")
      video.rating.should == 3.3
    end
  end
end
