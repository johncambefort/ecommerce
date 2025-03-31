# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Coffee.blend_name }
    brand { Faker::Company.name }
    price { 5.99 }
  end
end
