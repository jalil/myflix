require 'spec_helper'

describe "parties/edit" do
  before(:each) do
    @party = assign(:party, stub_model(Party,
      :index => "MyString"
    ))
  end

  it "renders the edit party form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => parties_path(@party), :method => "post" do
      assert_select "input#party_index", :name => "party[index]"
    end
  end
end
