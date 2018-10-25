FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "This is a description for Item #{n}! Its great!" }
    sequence(:price)            { |n| n*2 }
    sequence(:inventory_count)  { |n| n*3 }
    image                       { "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiJ_9-306LeAhUExYMKHfa0DYMQjRx6BAgBEAU&url=https%3A%2F%2Fwww.formaggiokitchen.com%2Fshop%2Fshop-online%2Fhoney.html&psig=AOvVaw1qXscyJgCHHq8Y-EFIZSeo&ust=1540593305738970" }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
    user
  end
end
