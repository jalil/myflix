require 'spec_helper'

describe Friendship do 
   describe "Friendship Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
    end
end
