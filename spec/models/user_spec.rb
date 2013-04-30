# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string(255)
#  admin           :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
  let(:video) { Fabricate(:video) }
  let(:user) { Fabricate(:user) }

  subject { user }

  describe "#has_video_in_queue?" do
    context "video in queue" do
      before { user.queue_items.create(video: video) }
      it { should have_video_in_queue(video) }
    end

    context "no video in queue" do
      it { should_not have_video_in_queue(video) }
    end
  end

  describe "#videos_in_queue" do
    context "no videos in queue" do
      its(:videos_in_queue) { should == [] }
    end
    context "with videos in queue" do
      before { user.queue_items.create(video: video) }
      its(:videos_in_queue) { should == [video] }
    end
  end

  describe "#follow" do
    let(:alice) { Fabricate(:user) }
    let(:bob) { Fabricate(:user) }

    it "follows someone" do
      alice.follow(bob)
      alice.following_relationships.count.should == 1
    end

    it "does not follow oneself" do
      alice.follow(alice)
      Relationship.count.should == 0
    end

    it "does not create duplicate relationships" do
      Fabricate(:relationship, influencer: bob, follower: alice)
      alice.follow(bob)
      Relationship.count.should == 1
    end
  end

  it_behaves_like "tokenable" do
    let(:object) { User.create(full_name: "John Doe", password: "1234", email: "john@example.com") }
  end

end
