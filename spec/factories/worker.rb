FactoryBot.define do
  factory :worker do
    name { Faker::Name.name }
    company_name { Faker::Company.name }
    email { Faker::Internet.email }
  end
end
