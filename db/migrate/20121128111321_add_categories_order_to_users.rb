class AddCategoriesOrderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :categories_order, :string
  end
end
