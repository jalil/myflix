# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe QueueItem do
  describe "#rating" do
    context "user has a review on the video" do
      it "pulls the rating from the user review" do
        alice = Fabricate(:user)
        monk = Fabricate(:video)
        review = Fabricate(:review, video: monk, user: alice, rating: 4)
        queue_item = Fabricate(:queue_item, user: alice, video: monk)
        queue_item.rating.should == 4
      end
    end
    context "user does not have review on the video" do
      it "returns nil" do
        alice = Fabricate(:user)
        monk = Fabricate(:video)
        queue_item = Fabricate(:queue_item, user: alice, video: monk)
        queue_item.rating.should == nil

      end
    end
  end

  describe "#rating=" do
    let(:alice) { Fabricate(:user) }
    let(:monk) { Fabricate(:video) }
    let(:queue_item) { Fabricate(:queue_item, user: alice, video: monk) }

    it "sets the rating on the view if the review is present" do
      review = Fabricate(:review, video: monk, user: alice, rating: 4)
      queue_item.rating = 2
      review.reload.rating.should == 2
    end

    it "creates a new review if there is no review for the video" do
      queue_item.rating = 2
      alice.reviews.first.rating.should == 2
    end
  end
end
