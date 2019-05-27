# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# user1 = User.create(email: 'smokingmouth@icloud.com', password_digest: 'string', role: 0, active: true, name: 'Tom Wesselmann', address: '550 Park Ave', city: 'New York City', state: 'NY', zip: 10001 )
#
# item1 = Item.create(name: 'Smoker #12', active: true, price: 96_000, description: 'Simplicity while demanding attention', image: 'https://www.moma.org/media/W1siZiIsIjM0NzQ2NyJdLFsicCIsImNvbnZlcnQiLCItcmVzaXplIDUxMng1MTJcdTAwM2UiXV0.jpg?sha=8ebf02b9e3025565', inventory: 23)
# item2 = Item.create(name: 'Study for Mouth', active: true, price: 85_000, description: 'Bold iconic image from a different time', image:'https://www.moma.org/media/W1siZiIsIjM0NzQ2NyJdLFsicCIsImNvbnZlcnQiLCItcmVzaXplIDUxMng1MTJcdTAwM2UiXV0.jpg?sha=8ebf02b9e3025565', inventory: 14)
# item3 = Item.create(name: 'Smoker #8', active: true, price: 125_000, description: 'Large and dramatic', image:'https://static01.nyt.com/images/2016/08/22/t-magazine/art/wesselmann-art-slide-C6BW/wesselmann-art-slide-C6BW-jumbo.jpg?quality=90&auto=webp', inventory: 26)
# item4 = Item.create(name: 'Mouth #2', active: true, price: 13_000, description: 'Can not be missed.', image:'https://i.pinimg.com/originals/e6/90/e3/e690e38299ac4f18f7cb7a2c59daa240.jpg', inventory: 2)
#
# user1.items << item1
# user1.items << item2
# user1.items << item3
# user1.items << item4
#
# user2 = User.create(email: 'polkadot@icloud.com', password_digest: 'string', role: 1, active: true, name: 'Yayoi Kusama', address: '1450 Park Ave', city: 'New York City', state: 'NY', zip: 10013 )
#
# item5 = Item.create(name: 'Red Dots', active: true, price: 32_000, description: 'Modern art pioneer', image: 'https://data.whicdn.com/images/138605591/large.jpg', inventory: 23)
# item6 = Item.create(name: 'Infinity Dots', active: true, price: 25_000, description: 'Colorful and happy', image:'https://mfas3.s3.amazonaws.com/styles/grid-3_thumbnail_retina/s3/4x3_kusama%2C-dots-infinity-nowh.jpg?itok=bxU_IXCD', inventory: 3)
# item7 = Item.create(name: 'Nets', active: true, price: 15_000, description: 'Dynamic', image:'https://www.phaidon.com/resource/kusama142a.jpg', inventory: 6)
# item8 = Item.create(name: 'Infinity Nets', active: true, price: 103_000, description: 'Stunning', image:'https://www.gillmanbarracks.com/files/events/201705241135/huge/170524064445726db69c8740659dee28fe1a0cc1ae.png', inventory: 2)
#
# user2.items << item5
# user2.items << item6
# user2.items << item7
# user2.items << item8

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
    name = Faker::Hipster.unique.words(1)
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
