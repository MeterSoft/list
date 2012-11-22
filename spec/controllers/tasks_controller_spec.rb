require 'spec_helper'

describe TasksController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  it 'should render new task form' do
    get :new
    assigns(:task).should_not be_nil
    response.should be_success
    response.should render_template(:new)
  end

  context 'index' do
    it "should render index form" do
      get :index
      assigns(:tasks).should_not be_nil
      response.should be_success
      response.should render_template(:index)
    end

    it "should show all tasks" do
      category = Category.create(:name => 'test', :user => @user)
      3.times do |i|
        Task.create(:category => category, :title => "task#{i}")
      end
      get :index
      assigns(:tasks).should have(3).items
    end

    it "should show tasks specific for category" do
      category1 = Category.create(:name => "test1", :user => @user)
      category2 = Category.create(:name => "test2", :user => @user)
      2.times do |i|
        Task.create(:category => category1, :title => "task#{i}")
      end
      3.times do |i|
        Task.create(:category => category2, :title => "task#{i}")
      end
      get :index, :category_id => category1.id
      assigns(:tasks).should have(2).items
    end
  end

  context "show" do
    it "should show task" do
      category = Category.create(:name => "test", :user => @user)
      task = Task.create(:title => "test", :category => category)
      get :show, :id => task.id
      assigns(:task).should_not be_nil
    end
  end

  context "edit" do
    it "should edit task" do
      category = Category.create(:name => "test", :user => @user)
      task = Task.create(:title => "test", :category => category)
      get :edit, :id => task.id
      assigns(:task).should_not be_nil
    end
  end

  context "create" do
    it "should create new task" do
      category = Category.create(:name => "test", :user => @user)
      post :create, :task => {:title => 'asdf', :category_id => category.id}
      assigns(:task).should be_valid
    end
  end

  context "update" do
    it "should update task" do
      category = Category.create(:name => "test", :user => @user)
      task = Task.create(:title => "test", :category => category)
      put :update, :id => task.id, :task => {:title => 'newtitle'}
      assigns(:task).should be_valid
      assigns(:task).title.should == 'newtitle'
    end
  end

  context "delete" do
    it "should delete task" do
      category = Category.create(:name => "test", :user => @user)
      task = Task.create(:title => "test", :category => category)
      delete :destroy, :id => task.id
      assigns(:task).should be_destroyed
    end
  end
end
