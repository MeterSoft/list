require 'spec_helper'

describe TasksOrdersController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    controller.stub(:current_user).and_return(@user)
  end

  context "#index" do
    it "should update attribute if category is selected" do
      category = FactoryGirl.create(:category, :user => @user)
      category.update_attribute(:category_tasks_order, ["1","2","3"])
      get :index, :category_id => category.id, :task => ["3","2","1"]
      category.reload
      category.category_tasks_order.should == ["3","2","1"]
    end

    it "should update attribute if category is not selected" do
      @user.update_attribute(:all_tasks_order, ["1","2","3"])
      get :index, :task => ["3","2","1"]
      @user.all_tasks_order.should == ["3","2","1"]
    end
  end

end