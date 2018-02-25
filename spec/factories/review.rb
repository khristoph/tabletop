
FactoryBot.define do
  factory :review do
    rating 4
    comment "Lorem ipsum comment."
    association :game, factory: :game
    association :user, factory: :user

    end

    trait :invalid_review do
      comment nil
    end
  end