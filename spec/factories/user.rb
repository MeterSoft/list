FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    sequence :email do |n|
      "email#{n}@factory.com"
    end
    password 'password'
  end
end