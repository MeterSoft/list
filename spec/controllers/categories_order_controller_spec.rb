require "spec_helper"

describe CategoriesOrdersController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    controller.stub(:current_user).and_return(@user)
    controller.stub(:authenticate_user!).and_return(true)
  end

  context "#index" do
    it "should update attribute" do
      @user.update_attribute(:categories_order, ["1","2","3"])
      get :index, :category => ["3","2","1"]
      @user.categories_order.should == ["3","2","1"]
    end
  end
end