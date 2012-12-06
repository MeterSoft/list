require "spec_helper"

describe User do
  context '#full_name' do
    it "should have fullname" do
      FactoryGirl.build(:user, :first_name => "Eugene", :last_name => "Korpan").full_name.should == "Eugene Korpan"
    end

    it "should have fullname without first_name" do
      FactoryGirl.build(:user, :first_name => nil, :last_name => "Korpan").full_name.should == "Korpan"
    end

    it "should have fullname without last_name" do
      FactoryGirl.build(:user, :first_name => "Eugene", :last_name => nil).full_name.should == "Eugene"
    end

    context "#email" do
      it "should not have uniquens" do
        FactoryGirl.create(:user, :email => "test@mail.ru").should be_true
        FactoryGirl.build(:user, :email => "test@mail.ru").should_not be_valid
      end
    end
  end
end
