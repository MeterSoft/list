class TasksOrdersController < ApplicationController

  def index
    tasks_ids = params[:task]
    # TODO: fix it
    render :nothing => true
  end
end
