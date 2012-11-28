class CategoriesController < ApplicationController

  before_filter :find_categories, :only => [:index]

  def index

    @category = Category.new

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    @category.user = current_user
    respond_to do |format|
      if @category.save
        find_categories
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    find_categories
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.js
    end
  end

  private

  def find_categories
    order = current_user.categories_order
    new_order = []
    order.each do |o|
       current_user.categories.find_by_id(o) ? new_order << current_user.categories.find_by_id(o) : o
    end
    @categories = new_order + (current_user.categories.all - new_order)
  end
end
