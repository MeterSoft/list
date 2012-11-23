require "spec_helper"

describe Task do
  context "#title_description" do
    it "should not have title and descriptions" do
      FactoryGirl.build(:task, :title => nil, :description => nil).should_not be_valid
    end

    it "should not have title" do
      FactoryGirl.build(:task, :title => nil, :description => "test").should be_valid
    end

    it "should not have description" do
      FactoryGirl.build(:task, :title => "test", :description => nil).should be_valid
    end
  end
end