FactoryBot.define do
  factory :recipe do
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 10, to: 100) }
    user
  end
end

