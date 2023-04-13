FactoryBot.define do
  factory :subscription do
    title { Faker::Vehicle.manufacture }
    price { Faker::Number.decimal(l_digits: 2) }
    frequency { Faker::Number.between(from: 1, to: 52) }
    tea { Tea.all.shuffle.sample }
    customer { Customer.all.shuffle.sample }
  end
end
