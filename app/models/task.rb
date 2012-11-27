class Task < ActiveRecord::Base
  attr_accessible :description, :title, :category_id, :category
  belongs_to :category
  validate :title_or_description
  has_one :tasks_order

  scope :join_order,joins("LEFT JOIN `tasks_orders` ON `tasks_orders`.`task_id` = `tasks`.`id`")
  scope :by_category, lambda { |category|
    category ? where("tasks_orders.category_id = #{category.id}") : where("tasks_orders.category_id is NULL")
  }


  def self.ordered_by_category(logged_in_user, category_id)
    category = Category.find_by_id(category_id)
    tasks = category ? category.tasks : logged_in_user.tasks
    if TasksOrder.any? && TasksOrder.where(:category_id => category_id).present?
      tasks = tasks.join_order
                   .by_category(category)
                   .order('tasks_orders.id')
    end
    tasks
  end


  private

  def title_or_description
    self.errors.add(:title, 'title or description should be specified') if title.blank? && description.blank?
  end
end
