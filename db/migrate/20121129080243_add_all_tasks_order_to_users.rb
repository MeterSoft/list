class AddAllTasksOrderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :all_tasks_order, :string
  end
end
