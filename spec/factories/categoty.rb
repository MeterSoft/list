FactoryGirl.define do
  factory :category do
    name 'shopping'
    association :user
  end
end