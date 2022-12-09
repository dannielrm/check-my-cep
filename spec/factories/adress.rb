FactoryBot.define do
    factory :address do
        zip { Faker::Number.number(digits: 8) }
        street_name { Faker::Address.street_name }
        neighborhood { Faker::Address.community }
        city { Faker::Address.city }
        state { Faker::Address.state }
    end
end