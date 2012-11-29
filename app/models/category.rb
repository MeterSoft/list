class Category < ActiveRecord::Base
  attr_accessible :name, :user_id, :user
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  validates :name, :presence => true

  serialize :category_tasks_order, Array

  def hi(user)
    user.full_name
  end

  def self.ordered_by_categories(logged_in_user)
    order = logged_in_user.categories_order || []
    new_order = []
    order.each do |o|
      logged_in_user.categories.find_by_id(o) ? new_order << logged_in_user.categories.find_by_id(o) : o
    end
    new_order + (logged_in_user.categories.all - new_order)
  end
end
