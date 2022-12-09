# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require 'faker'

Customer.destroy_all
Address.destroy_all

10.times do
    customer = Customer.create(name: Faker::Games::Pokemon.name)
    Address.create(
        customer: customer,
        zip: Faker::Number.number(digits: 8),
        street_name: Faker::Address.street_name,
        neighborhood: Faker::Address.community,
        city: Faker::Address.city,
        state: Faker::Address.state
    )
end