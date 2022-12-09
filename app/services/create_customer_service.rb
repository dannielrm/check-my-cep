class CreateCustomerService
    def initialize(customers)
        @customers = customers
    end

    def call
        @customers.each do |row|
            customer = Customer.create(
                name: row['name'],
                addresses_attributes: [{zip: fix_zip_size(row['cep'].to_s)}]
            )

            customer.addresses.each do |address|
                FetchAddressJob.perform_later(address)
            end if customer.valid?
        end
    end

    def fix_zip_size(zip)
        zip.rjust(8, '0')
    end
end