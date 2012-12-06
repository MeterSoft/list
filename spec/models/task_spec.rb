require "spec_helper"

describe Task do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

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

  context "#ordered_by_tasks" do
    context "category not found" do
      it "all_tasks_order is nil" do
        category = FactoryGirl.create(:category, :user => @user)
        category2 = FactoryGirl.create(:category, :user => @user)

        task1 = FactoryGirl.create(:task, :category => category, :user => @user)
        task2 = FactoryGirl.create(:task, :category => category, :user => @user)

        task3 = FactoryGirl.create(:task, :category => category2, :user => @user)
        task4 = FactoryGirl.create(:task, :category => category2, :user => @user)

        Task.ordered_by_tasks(@user, nil).should == [task1,task2,task3,task4]
      end

      it "all_tasks_order is not nil" do
        category = FactoryGirl.create(:category, :user => @user)
        category2 = FactoryGirl.create(:category, :user => @user)

        task1 = FactoryGirl.create(:task, :category => category, :user => @user)
        task2 = FactoryGirl.create(:task, :category => category, :user => @user)

        task3 = FactoryGirl.create(:task, :category => category2, :user => @user)
        task4 = FactoryGirl.create(:task, :category => category2, :user => @user)
        @user.update_attribute(:all_tasks_order, [task4.id,task1.id,task3.id,task2.id])


        Task.ordered_by_tasks(@user, nil).should == [task4,task1,task3,task2]
      end
    end

    context "category is selected" do
      it "category_tasks_order is nil" do
        category = FactoryGirl.create(:category, :user => @user)
        category2 = FactoryGirl.create(:category, :user => @user)

        task1 = FactoryGirl.create(:task, :category => category, :user => @user)
        task2 = FactoryGirl.create(:task, :category => category, :user => @user)

        task3 = FactoryGirl.create(:task, :category => category2, :user => @user)
        task4 = FactoryGirl.create(:task, :category => category2, :user => @user)

        Task.ordered_by_tasks(@user, category.id).should == [task1,task2]
      end

      it "category_tasks_order is not nil" do
        category = FactoryGirl.create(:category, :user => @user)
        category2 = FactoryGirl.create(:category, :user => @user)

        task1 = FactoryGirl.create(:task, :category => category, :user => @user)
        task2 = FactoryGirl.create(:task, :category => category, :user => @user)

        task3 = FactoryGirl.create(:task, :category => category2, :user => @user)
        task4 = FactoryGirl.create(:task, :category => category2, :user => @user)
        category2.update_attribute(:category_tasks_order, [task4.id,task3.id])

        Task.ordered_by_tasks(@user, category2.id).should == [task4,task3]
      end
    end
  end


end