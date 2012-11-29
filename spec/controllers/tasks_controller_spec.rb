require 'spec_helper'

describe TasksController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
    controller.stub(:current_user).and_return(@user)
  end

  it 'should render new task form' do
    get :new
    assigns(:task).should_not be_nil
    response.should be_success
    response.should render_template(:new)
  end

  context 'index' do
    it "should render index form" do
      Task.should_receive(:ordered_by_tasks).and_return([])
      get :index
      assigns(:tasks).should_not be_nil
      response.should be_success
      response.should render_template(:index)
    end

    it "should show all tasks" do
      category = FactoryGirl.create(:category, :user => @user)
      3.times do |i|
        FactoryGirl.create(:task, :category => category)
      end
      get :index
      assigns(:tasks).should have(3).items
    end

    it "should show tasks specific for category" do
      category1 = FactoryGirl.create(:category, :user => @user)
      category2 = FactoryGirl.create(:category, :user => @user)
      2.times do |i|
        FactoryGirl.create(:task, :category => category1)
      end
      3.times do |i|
        FactoryGirl.create(:task, :category => category2)
      end
      get :index, :category_id => category1.id
      assigns(:tasks).should have(2).items
    end
  end

  context "show" do
    it "should show task" do
      category = FactoryGirl.create(:category, :user => @user)
      task = FactoryGirl.create(:task, :category => category)
      get :show, :id => task.id
      assigns(:task).should_not be_nil
    end
  end

  context "edit" do
    it "should edit task" do
      category = FactoryGirl.create(:category, :user => @user)
      task = FactoryGirl.create(:task, :category => category)
      get :edit, :id => task.id
      assigns(:task).should_not be_nil
    end
  end

  context "create" do
    it "should create new task" do
      Task.should_receive(:ordered_by_tasks).and_return([])
      category = FactoryGirl.create(:category, :user => @user)
      post :create, :task => {:title => 'asdf', :category_id => category.id}
      assigns(:task).should be_valid
    end
  end

  context "update" do
    it "should update task" do
      category = FactoryGirl.create(:category, :user => @user)
      task = FactoryGirl.create(:task, :category => category)
      put :update, :id => task.id, :task => {:title => 'newtitle'}
      assigns(:task).should be_valid
      assigns(:task).title.should == 'newtitle'
    end
  end

  context "delete" do
    it "should delete task" do
      Task.should_receive(:ordered_by_tasks).and_return([])
      category = FactoryGirl.create(:category, :user => @user)
      task = FactoryGirl.create(:task, :category => category)
      delete :destroy, :id => task.id
      assigns(:task).should be_destroyed
    end
  end

  it "should use ordered_by_tasks" do
    Task.should_receive(:ordered_by_tasks).and_return([])
    get :index
  end
end
