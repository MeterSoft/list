class AddCategoryTasksOrderToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :category_tasks_order, :string
  end
end
