FactoryBot.define do
  factory :user do
    sequence(:name)             { |n| "Person ##{n}" }
    sequence(:street_address)   { |n| "#{n} Main Street" }
    sequence(:city)             { |n| "Denver #{n}" }
    sequence(:state)            { |n| "CO#{n}" }
    sequence(:email)            { |n| "user#{n}@mail.com" }
    sequence(:password)         { |n| "password#{n}" }
    zip                         { 12345 }
    role                        { 0 }
    active                      { true }
    created_at                  { Time.now }
    updated_at                  { Time.now }
  end
end
