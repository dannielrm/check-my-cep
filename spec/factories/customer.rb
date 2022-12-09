FactoryBot.define do
    factory :customer do
        name { Faker::Games::Pokemon.name }
    end
end