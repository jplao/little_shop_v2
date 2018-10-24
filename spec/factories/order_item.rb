FactoryBot.define do
  factory :order_item do
    sequence(:item_quantity)    { |n| n }
    sequence(:item_price)       { |n| n*2.50 }
    created_at                  { Time.now }
    updated_at                  { Time.now }
    order
    item 
  end
end
