FactoryBot.define do
  factory :search_analytic do
    query { Faker::Quotes::Shakespeare.hamlet }

    user
  end
end
