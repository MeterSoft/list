class Task < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :category
end
