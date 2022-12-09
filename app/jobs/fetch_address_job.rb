require 'net/http'

class FetchAddressJob < ApplicationJob
    queue_as :default

    def perform(address)
        sleep(1.second) # Stupid way to not becaught in viacep's rate limit. Improve later

        uri = URI("https://viacep.com.br/ws/#{address.zip}/json")
        response = Net::HTTP.get(uri)
        parsed_response = JSON.parse(response)
        if parsed_response['erro']
            address.update(invalid_zip: true)
        else
            address.update(
                street_name: parsed_response['logradouro'],
                neighborhood: parsed_response['bairro'],
                city: parsed_response['localidade'],
                state: parsed_response['uf']
            )
        end

    # Correctly rescuing the range of errors that an external request might throw is too time consuming
    # given my available deadline
    rescue StandardError
        address.update(invalid_zip: true)
    end
end
