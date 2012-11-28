class Task < ActiveRecord::Base
  attr_accessible :description, :title, :category_id, :category
  belongs_to :category
  validate :title_or_description

  scope :by_category, lambda { |category_id|
    category_id ? where(:category_id => category_id) : where({})
  }


  def self.ordered_by_category(logged_in_user, category_id)
    logged_in_user.tasks.by_category(category_id)
  end


  private

  def title_or_description
    self.errors.add(:title, 'title or description should be specified') if title.blank? && description.blank?
  end
end
