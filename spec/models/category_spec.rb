require "spec_helper"

describe Category do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

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

  context "#ordered_by_categories" do
    it "ordered if categories_order is nil" do
      category = FactoryGirl.create(:category, :user => @user)
      category2 = FactoryGirl.create(:category, :user => @user)
      Category.ordered_by_categories(@user).should == [category, category2]
    end

    it "ordered if categories_order is not nil" do
      category = FactoryGirl.create(:category, :user => @user)
      category2 = FactoryGirl.create(:category, :user => @user)
      @user.update_attribute(:categories_order, [category2.id, category.id])
      Category.ordered_by_categories(@user).should == [category2, category]
    end
  end
end