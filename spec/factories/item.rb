FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "This is a description for Item #{n}! Its great!" }
    sequence(:price)            { |n| n*2 }
    sequence(:inventory_count)  { |n| n*3 }
    image                       { "./apps/assets/images/honey.png" }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
    user
  end
end
