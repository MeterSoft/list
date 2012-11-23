FactoryGirl.define do
  factory :task do
    title "title"
    description "description"
    association :category, :factory => :category
  end
end