class Category < ActiveRecord::Base
  attr_accessible :name , :user_id, :user
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  validates :name, :presence => true
  has_one :categories_order
  has_many :tasks_orders

  def hi(user)
    user.full_name
  end
end
