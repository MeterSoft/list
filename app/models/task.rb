class Task < ActiveRecord::Base
  attr_accessible :description, :title, :category_id
  belongs_to :category
end
