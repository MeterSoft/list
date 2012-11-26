require "spec_helper"

describe CategoriesOrdersController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  it "should save id" do
    5.times do
      FactoryGirl.create(:categories_order)
    end


  end
end