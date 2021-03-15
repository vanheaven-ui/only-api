require 'faker'

FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
  end
end