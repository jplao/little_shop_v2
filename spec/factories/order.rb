FactoryBot.define do
  factory :order do
    status       { "pending" }
    active       { true }
    created_at   { Time.now }
    updated_at   { Time.now }
    user
  end
end
