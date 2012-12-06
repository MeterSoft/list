FactoryGirl.define do
  factory :task do
    title "title"
    description "description"
    association :category, :factory => :category
    association :user, :factory => :user
  end

end