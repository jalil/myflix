require 'spec_helper'

describe "parties/index" do
  before(:each) do
    assign(:parties, [
      stub_model(Party,
        :index => "Index"
      ),
      stub_model(Party,
        :index => "Index"
      )
    ])
  end

  it "renders a list of parties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Index".to_s, :count => 2
  end
end
