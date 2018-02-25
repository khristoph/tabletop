require 'rack/test'

FactoryBot.define do
  factory :game do
    title "Dixit"
    description "Lorem ipsum dolor"
    creator "Dan Harmon"
    rule_link "www.example.com"
    association :category, factory: :category
    association :user, factory: :user
    game_img Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/arcane.png")

    end

    trait :invalid do
      title nil
    end

  end



