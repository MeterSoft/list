class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password
  has_many :categories
  has_many :tasks, :through => :categories
  validates :email, :uniqueness => true
  validates :first_name, :last_name, :email, :password, :presence => true

  serialize :categories_order, Array

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
