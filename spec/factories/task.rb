FactoryGirl.define do
  factory :task do
    title "title"
    description "description"
    association :category, :factory => :category
  end

  factory :ordered_task, :parent => :task do
    association :tasks_order, :factory => :tasks_order
  end
end