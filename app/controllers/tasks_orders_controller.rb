class TasksOrdersController < ApplicationController

  def index
    params[:category_id] ? current_user.categories.find(params[:category_id]).update_attribute(:category_tasks_order, params[:task])
                         : current_user.update_attribute(:all_tasks_order, params[:task])
    render :nothing => true
  end
end
