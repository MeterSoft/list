class Category < ActiveRecord::Base
  attr_accessible :name , :user_id, :user
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  validates :name, :presence => true

  def hi(user)
    user.full_name
  end
end
