FactoryGirl.define do
  factory :category do
    name 'shopping'
    association :user, :factory => :user
  end
end