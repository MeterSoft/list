class TasksOrdersController < ApplicationController

  def index
    tasks_ids = params[:task]
    if params[:category_id]
      Category.find(params[:category_id]).tasks_order.destroy_all
      tasks_ids.each do |task_id|
        TasksOrder.create(:task_id => task_id, :category_id => params[:category_id])
      end
    else
      tasks_ids.each do |task_id|
        Task.find(task_id).tasks_order.destroy
        TasksOrder.create(:task_id => task_id)
      end
    end

    render :nothing => true
  end
end
