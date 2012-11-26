class CategoriesOrdersController < ApplicationController

  def index
    categories_ids = params[:category]
    CategoriesOrder.destroy_all
    categories_ids.each do |category_id|
      CategoriesOrder.create(:category_id => category_id)
    end
    render :nothing => true
  end

end
