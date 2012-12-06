class Task
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  field :category_id, type: Integer
  field :user_id, type: Integer

  attr_accessible :description, :title, :category_id, :user_id, :category
  belongs_to :category
  belongs_to :user
  validate :title_or_description

  def self.ordered_by_tasks(logged_in_user, category_id)
    if category_id
      order = logged_in_user.categories.find(category_id).category_tasks_order || []
      new_order = []
      order.each do |o|
        logged_in_user.categories.find(category_id).tasks.find(o) ? new_order << logged_in_user.categories.find(category_id).tasks.find(o) : o
      end
      new_order + (logged_in_user.categories.find(category_id).tasks - new_order)
    else
      order = logged_in_user.all_tasks_order || []
      new_order = []
      order.each do |o|
        logged_in_user.tasks.find(o) ? new_order << logged_in_user.tasks.find(o) : o
      end
      new_order + (logged_in_user.tasks - new_order)
    end
  end


  private

  def title_or_description
    self.errors.add(:title, 'title or description should be specified') if title.blank? && description.blank?
  end
end
