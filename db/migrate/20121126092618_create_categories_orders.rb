class CreateCategoriesOrders < ActiveRecord::Migration
  def change
    create_table :categories_orders do |t|
      t.integer :category_id

      t.timestamps
    end
  end
end
