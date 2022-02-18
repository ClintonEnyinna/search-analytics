FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    author { Faker::Book.author }
    body { Faker::Quotes::Shakespeare.hamlet }
  end
end
