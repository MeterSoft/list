class CreateTasksOrders < ActiveRecord::Migration
  def change
    create_table :tasks_orders do |t|
      t.integer :task_id
      t.integer :category_id

      t.timestamps
    end
  end
end
