# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string(255)
#  full_name            :string(255)
#  password_digest      :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  password_reset_token :string(255)
#

require 'spec_helper'

describe User do

  describe "validations for User" do
    it { should validate_presence_of(:full_name)}
    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password)}
  end

  describe "#has_a_video_in_queue?" do
    let(:video) {Fabricate(:video)}
    let(:user)  {Fabricate(:video)}
    
  
    subject {user}

    context "video in queue" do
      before { user.line_items.create(video_id: video.id) }
      it { should has_a_video_in_queue?(video) }
    end
  end

      it { should respond_to(:videos) }    
      it { should respond_to(:reviews) }    
      it { should respond_to(:friendships) }    
      it { should respond_to(:inverse_friendships) }    
      it { should respond_to(:inverse_friends) }    
      it { should respond_to(:line_items) }    


      describe "#follow" do
        let(:bob) { Fabricate(:user)}
        let(:hope) { Fabricate(:user)}
        
        it "follws someone" do
          Friendship.create(user_id: bob.id, friend_id: hope.id)
          bob.friendships.count.should == 1
        end

        it "does not follow oneself" do
          Friendship.create(user_id: bob.id, friend_id: bob.id)
          bob.friends(bob)
          bob.friendships.count.should == 0
        end
      end
end
