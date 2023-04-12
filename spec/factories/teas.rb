FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.between(from: 150, to: 400) }
    brew_time { Faker::Number.between(from: 5, to: 15) }
  end
end
