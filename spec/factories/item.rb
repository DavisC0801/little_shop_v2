# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "Description #{n}" }
    sequence(:price)            { |n| n * 2 }
    sequence(:inventory)        { |n| n * 3 }
    sequence(:image)            { |n| "https://picsum.photos/100/300?image=#{n}" }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
    user
  end
end
