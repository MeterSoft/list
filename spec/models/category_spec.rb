require "spec_helper"

describe Category do
  context "#name" do
    it "should not have name" do
      FactoryGirl.build(:category, :name => "").should_not be_valid
    end

    it "should not have name" do
      FactoryGirl.build(:category, :name => nil).should_not be_valid
    end
  end

  # Useless spec just for information
  it "should call full_name method" do
    mock_object = double('User')
    mock_object.should_receive(:full_name).and_return("Eugene")
    category = FactoryGirl.build(:category)
    category.hi(mock_object).should == "Eugene"
  end
end