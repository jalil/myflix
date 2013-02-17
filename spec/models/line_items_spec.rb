# == Schema Information
#
# Table name: lines
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  video_id   :integer
#

require 'spec_helper'

describe LineItem do
    describe "associations" do
      it { should belong_to(:video)}
      it { should belong_to(:user)}
    end

    describe "validations" do
      it { should validate_presence_of(:video_id)}
      it { should validate_presence_of(:user_id) }
    end
end
