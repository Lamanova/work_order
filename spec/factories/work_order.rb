FactoryBot.define do
  factory :work_order do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    deadline { Faker::Date.forward(50) }
  end
end
