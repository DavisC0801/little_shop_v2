FactoryBot.define do
  factory :user do
    sequence(:name)             { |n| "Name ##{n}" }
    sequence(:address)          { |n| "Address #{n} " }
    sequence(:city)             { |n| "City #{n}" }
    sequence(:state)            { |n| "State #{n}" }
    sequence(:zip)              { |n| "Zip #{n}" }
    sequence(:email)            { |n| "user_#{n}@icloud.com" }
    sequence(:password)         { |n| "password#{n}" }
    role                        { 0 }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
  end
end
