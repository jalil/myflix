# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  comment    :text
#  video_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Review do
  describe " association between models" do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
  end

  describe "validations of models" do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:comment) }
  end
end
