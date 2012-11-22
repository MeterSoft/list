class Task < ActiveRecord::Base
  attr_accessible :description, :title, :category_id, :category
  belongs_to :category
  validate :title_or_description

  private

  def title_or_description
    self.errors.add(:title, 'title or description should be specified') if title.blank? && description.blank?
  end
end
