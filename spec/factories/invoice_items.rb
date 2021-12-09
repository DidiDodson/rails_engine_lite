FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.number(digits: 4) }
  end
end
