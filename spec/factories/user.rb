require 'faker'

FactoryBot.define do 
  factory :user do
    email { Faker::Internet.email }
    password { '123456AbcDe' } 
  end
end