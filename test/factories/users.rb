# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'tenderlove'
    email 'tenderlove@example.com'
    password 'password'
  end
end
