require "spec_helper"

describe CategoriesOrdersController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
    controller.stub(:current_user).and_return(@user)
  end

  context "#index" do
    it "should update attribute" do
      @user.update_attribute(:categories_order, ["1","2","3"])
      get :index, :category => ["3","2","1"]
      @user.categories_order.should == ["3","2","1"]
    end
  end
end