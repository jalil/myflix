require "spec_helper"

describe Video do
    
    it { should belong_to(:category) }
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}

   describe "#search_by_title" do
      it "return an empty array" do
      Video.create(name: "Monk", description: "Monk is awsome")
      Video.search_by_title("Monk").should eq []
    end
  end
end

