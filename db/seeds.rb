# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Emptying Database...'
Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

puts 'Seeding Customers...'
10.times do
  Customer.create!({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  })
end

puts 'Seeding Teas...'
20.times do
  Tea.create!({
    title: Faker::Tea.variety,
    description: Faker::Tea.type,
    temperature: Faker::Number.between(from: 150, to: 400),
    brew_time: Faker::Number.between(from: 5, to: 15)
  })
end

puts 'Seeding Subscriptions...'
30.times do
  Subscription.create!({
    title: Faker::Vehicle.manufacture,
    price: Faker::Number.decimal(l_digits: 2),
    frequency: Faker::Number.between(from: 1, to: 52),
    tea_id: Tea.all.shuffle.sample.id,
    customer_id: Customer.all.shuffle.sample.id
  })
end

puts 'Database Seeded!'