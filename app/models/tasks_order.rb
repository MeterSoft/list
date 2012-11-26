class TasksOrder < ActiveRecord::Base
  attr_accessible :category_id, :task_id
  belongs_to :task
end
