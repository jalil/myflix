require 'spec_helper'

describe "parties/show" do
  before(:each) do
    @party = assign(:party, stub_model(Party,
      :index => "Index"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Index/)
  end
end
