# == Schema Information
#
# Table name: videos
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  small_cvr_url :binary
#  lrg_cvr_url   :binary
#  description   :text
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "spec_helper"

describe Video do
    
    it { should belong_to(:category) }
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}

     it "has a valid factory" do
	FactoryGirl.create(:video).should be_valid
     end
     
      it "it is invalid without a video name" do
	FactoryGirl.build(:video, name: nil).should_not be_valid
      end
     
      it "it is invalid without a video description" do
	FactoryGirl.build(:video, description: nil).should_not be_valid
      end
      #it "is invalid with duplicate video name" do 
#	FactoryGirl.create(:video, name:"Monk")
#	FactoryGirl.build(:video, name:"Monk").should_not be_valid
 #      end
      it "returns result of matched search results only" do
        monk = FactoryGirl.create(:video, name: "Monk")
        man = FactoryGirl.create(:video, name: "Man")
        funnyman = FactoryGirl.create(:video, name: "Funnyman")

        Video.search_by_title("M").should eq [monk, man]
      end

      it "returns result of matched search results only" do
         monk = FactoryGirl.create(:video, name: "Monk")
         man = FactoryGirl.create(:video, name: "Man")
         funnyman = FactoryGirl.create(:video, name: "Funnyman")

         Video.search_by_title("M").should_not  include funnyman

      end
end

