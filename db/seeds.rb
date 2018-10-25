# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Merchant Users
10.times do
  User.create(name: Faker::FunnyName.two_word_name,
              street_address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip: Faker::Address.zip,
              email: Faker::Internet.unique.email,
              password: Faker::Internet.password,
              role: 1)
end

# Merchant Items
User.all.each do |user|
  number_of_items = rand(0..15)
  number_of_items.times do
    name = Faker::Hipster.unique.sentence(2)
    description = Faker::Hipster.paragraph(2, true, 4)
    image = Faker::Placeholdit.image('50x50', 'jpg')
    price = Faker::Commerce.price(range = 0..10.0, as_string = true)
    item = user.items.create(name: name, description: description, image: image, price: price, inventory_count: rand(0..25))
  end
end

# Regular Users
10.times do
  User.create(name: Faker::FunnyName.two_word_name,
              street_address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip: Faker::Address.zip,
              email: Faker::Internet.unique.email,
              password: Faker::Internet.password,
            )
end

# Admin User
User.create(name: Faker::FunnyName.two_word_name,
            street_address: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zip: Faker::Address.zip,
            email: Faker::Internet.unique.email,
            password: Faker::Internet.password,
            role: 2)

# User Orders
User.all.each do |user|
  number_of_orders = rand(0..15)
  number_of_orders.times do
    order = user.orders.create()
  end
end

# Order Items
Order.all.each do |order|
  number_of_items = rand(0..10)
  number_of_items.times do
    item = Item.all.shuffle.pop
    order_item = order.order_items.create(item_id: item.id, item_price: item.price, item_quantity: rand(0..10))
  end
end
