FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { 1 }
    status { "MyString" }
    frequency { 1 }
    tea { nil }
    customer { nil }
  end
end
