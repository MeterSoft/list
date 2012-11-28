require 'spec_helper'

describe TasksOrdersController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    controller.stub(:current_user).and_return(@user)
  end

  it "if category is not nil" do
    category = FactoryGirl.create(:category, :user => @user)

    get :index, :task => [3,4,1,2], :category_id => category.id

    TasksOrder.all.should have(4).items

    TasksOrder.first.task_id.should == 3
    TasksOrder.last.task_id.should == 2
  end

  it "if category is nil" do
    category = FactoryGirl.create(:category, :user => @user)

    get :index, :task => [3,4,1,2]

    TasksOrder.all.should have(4).items

    TasksOrder.first.task_id.should == 3
    TasksOrder.last.task_id.should == 2

  end

end