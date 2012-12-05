class Category

  include Mongoid::Document

  field :name, type: String
  field :user_id, type: Integer
  field :category_tasks_order, type: Array


#  attr_accessible :name, :user_id, :user
  belongs_to :user
  has_many :tasks
  validates :name, :presence => true

  def hi(user)
    user.full_name
  end

  def self.ordered_by_categories(logged_in_user)
    order = logged_in_user.categories_order || []
    new_order = []
    order.each do |o|
      logged_in_user.categories.find(o) ? new_order << logged_in_user.categories.find(o) : o
    end
    new_order + (logged_in_user.categories - new_order)
  end
end
