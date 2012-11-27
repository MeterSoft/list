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

  context "#ordered_by_category" do

    it "tasksorder.any? is nil and category is nil" do
      category = FactoryGirl.create(:category, :user => @user)
      task = FactoryGirl.create(:task, :category => category)
      Task.ordered_by_category(@user, nil).should == Task.all
    end

    it "category is nil" do
      category = FactoryGirl.create(:category, :user => @user)
      3.times do
        FactoryGirl.create(:ordered_task, :category => category)
      end

      Task.ordered_by_category(@user, category.id).should == Task.all
      Task.ordered_by_category(@user, category.id).should have(3).items
    end

    it "should return ordered list of tasks within category" do
      category = FactoryGirl.create(:category, :user => @user)

      task1 = FactoryGirl.create(:ordered_task, :category => category)
      task1.tasks_order.update_attribute(:category_id, category.id)

      task2 = FactoryGirl.create(:ordered_task, :category => category)
      task2.tasks_order.update_attribute(:category_id, category.id)

      task3 = FactoryGirl.create(:ordered_task, :category => category)
      task3.tasks_order.update_attribute(:category_id, category.id)

      category2 = FactoryGirl.create(:category, :user => @user)

      task4 = FactoryGirl.create(:ordered_task, :category => category2)
      task4.tasks_order.update_attribute(:category_id, category2.id)

      Task.ordered_by_category(@user, category.id).should == [task1, task2, task3]
      Task.ordered_by_category(@user, category2.id).should == [task4]

      first_tasks_order = task1.tasks_order
      last_tasks_order = task3.tasks_order

      first_tasks_order.update_attribute(:task_id, task3.id)
      last_tasks_order.update_attribute(:task_id, task1.id)

      Task.ordered_by_category(@user, category.id).should == [task3, task2, task1]

    end
  end
end