require 'spec_helper'

describe Video do
   it "saves itself"  do
	 video = Video.new(:name =>"Monk", small_cvr_url: "monk.jpg", lrg_cvr_url: "monk_large.jpg", description: "Former", category_id: 1)
	 video.save
	 Video.first.name.should == "Monk"
    end
  
    it "should require a name, description and images" do
	 Video.new(:name =>"").should_not be_valid
	 Video.new(:description =>"").should_not be_valid
    end
    
    it { should belong_to(:category) }
    it { should validate_presence_of (:name)}
    it { should validate_presence_of (:description)}
 
end
