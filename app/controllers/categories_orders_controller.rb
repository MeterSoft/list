class CategoriesOrdersController < ApplicationController

  def index
    current_user.update_attribute(:categories_order, params[:category])
    render :nothing => true
  end

end
