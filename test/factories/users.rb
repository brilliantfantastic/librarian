# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'tenderlove'
    email 'tenderlove@example.com'
    password 'password'
  end

  factory :other_user, class: 'User' do
    username 'issacs'
    email 'issacs@example.com'
    password 'hamburger'
  end
end
