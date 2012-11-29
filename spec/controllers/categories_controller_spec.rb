require "spec_helper"

describe CategoriesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    controller.stub(:current_user).and_return(@user)
  end

  context "index" do
    it "index" do
      Category.should_receive(:ordered_by_categories).and_return([])
      FactoryGirl.create(:category, :user => @user)
      get :index
      expect { assigns(:category) }.to_not be_nil
      response.should be_success
    end
  end

  context "show" do
    it "show" do
      get :show, :id => FactoryGirl.create(:category).id
      assigns(:category).should_not be_nil
      response.should be_success
    end
  end

  context "new" do
    it "new" do
      get :new
      assigns(:category).should_not be_nil
      response.should be_success
    end
  end

  context "edit" do
    it "edit" do
      get :edit, :id => FactoryGirl.create(:category).id
      assigns(:category).should_not be_nil
    end
  end

  context "create" do
    it "create" do
      Category.should_receive(:ordered_by_categories).and_return([])
      FactoryGirl.create(:category, :user => @user)
      post :create, :category => FactoryGirl.attributes_for(:category)
      assigns(:category).should be_valid
      assigns(:categories).should_not be_nil
    end
  end

  context "update" do
    it "update" do
      category = FactoryGirl.create(:category)
      put :update, :id => category.id, :category => {:name => "test"}
      assigns(:category).should be_valid
      assigns(:category).name.should == "test"
    end
  end

  context "delete" do
    it "delete" do
      Category.should_receive(:ordered_by_categories).and_return([])
      category = FactoryGirl.create(:category)
      delete :destroy, :id => category.id
      assigns(:category).should be_destroyed
    end
  end

  it "should use ordered_by_categories" do
    Category.should_receive(:ordered_by_categories).and_return([])
    get :index
  end
end