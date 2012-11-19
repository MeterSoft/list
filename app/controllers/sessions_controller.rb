class SessionsController < ApplicationController

  skip_before_filter :require_login, :only => [:new, :create]

  def new
  end

  def create
    user = User.where(:email => params[:email], :password => params[:password]).first
    if user
      session[:user_id] = user.id
      redirect_to categories_path
    else
      @message = 'wrong login or pasword'
      render :action => :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end


end
