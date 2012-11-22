require "spec_helper"

describe Category do
  context "#name" do
    it "should not have name" do
      category = Category.new(:name => "")
      category.should_not be_valid
    end

    it "should not have name" do
      category = Category.new(:name => nil)
      category.should_not be_valid
    end
  end
end