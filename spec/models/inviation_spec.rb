require "spec_helper"

describe Invitation do
  it {should respond_to(:generate_token)}

  describe "associations" do
    it { should have_one(:recipient)}
    it { should belong_to(:sender)}
  end


  describe "associations" do
    it { should belong_to(:sender) }
    it { should have_one(:recipient) }
  end

  describe "validations" do
    it { should validate_presence_of(:recipient_name)}
  end
end
