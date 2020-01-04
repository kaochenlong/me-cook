FactoryBot.define do
  factory :recipe do
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    user
  end
end

