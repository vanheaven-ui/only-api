require 'faker'

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| Faker::Book.genre + n.to_s }
  end
end
