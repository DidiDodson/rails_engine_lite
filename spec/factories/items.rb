FactoryBot.define do
  factory :item, class: Item do
    association :merchant
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Number.within(range: 1..1000) }
    id { Faker::Number.unique.within(range: 1..1000000) }
  end
end
