
FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "cf#{n}@example.com"
    end
    password "password"
    password_confirmation "password"
  end
end