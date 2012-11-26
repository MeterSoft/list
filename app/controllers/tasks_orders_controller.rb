class TasksOrdersController < ApplicationController

  def index
    tasks_ids = params[:task]
    if params[:category_id]
      Category.find(params[:category_id]).tasks_orders.destroy_all
      tasks_ids.each do |task_id|
        TasksOrder.create(:category_id => params[:category_id], :task_id => task_id)
      end
    end
    render :nothing => true
  end
end
