require "spec_helper"

describe User do
  context '#full_name' do
    it "should have fullname" do
      user = User.new
      user.first_name = "Eugene"
      user.last_name = "Korpan"

      user.full_name.should == "Eugene Korpan"
    end

    it "should have fullname without first_name" do
      user = User.new(:first_name => nil, :last_name => 'Korpan')

      user.full_name.should == 'Korpan'
    end

    it "should have fullname without last_name" do
      user = User.new(:first_name => 'Eugene', :last_name => nil)

      user.full_name.should == 'Eugene'
    end

    context "#email" do
      it "should not have uniquens" do
        User.create(:first_name => "test", :last_name => "test", :email => "test@mail.ru", :password => "test").should be_true
        user2 = User.new(:first_name => "test", :last_name => "test", :email => "test@mail.ru", :password => "test")
        user2.should_not be_valid
      end
    end
  end
end