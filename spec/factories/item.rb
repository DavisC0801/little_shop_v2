FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "Description #{n}" }
    sequence(:price)            { |n| n }
    sequence(:inventory)        { |n| n }
    sequence(:image)            { |n| "https://picsum.photos/100/300?image=#{n}" }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
    user
  end
end
