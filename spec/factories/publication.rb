require 'faker'

FactoryBot.define do
  factory :publication do
    title { Faker::Book.title }
    author { Faker::Book.author }
  end
end