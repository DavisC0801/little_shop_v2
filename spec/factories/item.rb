FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "#{n} Wonderful! " }
    sequence(:price)            { |n| n*2 }
    sequence(:inventory)        { |n| n*3 }
    image                       { 'string' }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
    user
  end
end
