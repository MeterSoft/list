require "spec_helper"

describe Task do
  context "#title_description" do
    it "should not have title and descriptions" do
      task = Task.new(:title => nil, :description => nil)
      task.should_not be_valid
    end

    it "should not have title" do
      task = Task.new(:title => nil, :description => "nil")
      task.should be_valid
    end

    it "should not have description" do
      task = Task.new(:title => "nil", :description => nil)
      task.should be_valid
    end
  end
end