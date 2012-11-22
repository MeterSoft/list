require 'spec_helper'

describe SessionsController do

  it 'should render login page' do
    get :new
    response.should be_success
  end

end
