<<<<<<< HEAD
=======
# frozen_string_literal: true

>>>>>>> 511be486a2f35edde651a338a7e950a81acfe6bf
FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "Description #{n}" }
<<<<<<< HEAD
    sequence(:price)            { |n| n }
    sequence(:inventory)        { |n| n }
=======
    sequence(:price)            { |n| n * 2 }
    sequence(:inventory)        { |n| n * 3 }
>>>>>>> 511be486a2f35edde651a338a7e950a81acfe6bf
    sequence(:image)            { |n| "https://picsum.photos/100/300?image=#{n}" }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
    user
  end
end
