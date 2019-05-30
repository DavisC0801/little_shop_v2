# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Merchants

5.times do
  User.create(name: Faker::Superhero.unique.name,
              address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip: Faker::Address.zip,
              email: Faker::Internet.unique.email,
              password: Faker::Internet.password,
              role: 2)
end

# Items per Merchant
User.all.each do |user|
  number_of_items = rand(1..8)
  number_of_items.times do
    name = Faker::Hipster.unique.word.upcase
    description = Faker::Hipster.paragraph
    image = Faker::Avatar.image
    price = Faker::Commerce.price(range = 1.00..100.00, as_string = true)
    item = user.items.create(name: name, description: description, image: image, price: price, inventory: rand(1..10), active: true)
  end
end

# Admin
User.create(name: Faker::Name.name,
            address: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zip: Faker::Address.zip,
            email: Faker::Internet.unique.email,
            password: Faker::Internet.password,
            role: 1)

# Regular User

15.times do
  User.create(name: Faker::Name.unique.name,
              address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip: Faker::Address.zip,
              email: Faker::Internet.unique.email,
              password: Faker::Internet.password)
end

# order items
Order.all.each do |order|
  number_of_items = rand(1..10)
  number_of_items.times do
    item = Item.all.shuffle.pop
    order_item = order.order_items.create(item_id: item.id, item_price: item.price, item_quantity: rand(1..10), fulfill: [true,false].sample)
  end
end
