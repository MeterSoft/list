FactoryGirl.define do
  factory :categories_order do
    association :category, :factory => :category
  end
end