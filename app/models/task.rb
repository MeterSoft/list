class Task < ActiveRecord::Base
  attr_accessible :description, :title, :category_id, :category
  belongs_to :category
  validate :title_or_description

  scope :by_category, lambda { |category_id|
    category_id ? where(:category_id => category_id) : where({})
  }


  def self.ordered_by_tasks(logged_in_user, category_id)
    if category_id
      order = logged_in_user.categories.find(category_id).category_tasks_order || []
      new_order = []
      order.each do |o|
        logged_in_user.categories.find(category_id).tasks.find_by_id(o) ? new_order << logged_in_user.categories.find(category_id).tasks.find_by_id(o) : o
      end
      @tasks = new_order + (logged_in_user.categories.find(category_id).tasks - new_order)
    else
      order = logged_in_user.all_tasks_order || []
      new_order = []
      order.each do |o|
        logged_in_user.tasks.find_by_id(o) ? new_order << logged_in_user.tasks.find_by_id(o) : o
      end
      new_order + (logged_in_user.tasks.all - new_order)
    end
  end


  private

  def title_or_description
    self.errors.add(:title, 'title or description should be specified') if title.blank? && description.blank?
  end
end
