require 'rails_helper'

RSpec.describe Customer, type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:customer, 10)
      get '/api/customers'
    end

    it 'returns all customers' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:my_customer) { FactoryBot.create(:customer) }
      let!(:my_address) { FactoryBot.create(:address, customer: my_customer) }

      before do
        post '/api/customers', params: {
          _json: [{
            name: my_customer.name,
            cep: my_address.zip
          }]
        }
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the name' do
        expect(json.first['name']).to eq(my_customer.name)
      end

      it 'returns an address' do
        expect(json.first['addresses'].length).to eq(1)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/customers', params: {
          _json: [{
            name: '',
          }]
        }
      end

      it 'skips the creation of the customers' do
        expect(json).to eq([])
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:customer) { FactoryBot.create(:customer) }

    before do
      delete "/api/customers/#{customer.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # More use cases could be provided, specially to test zip format errors, but I'm tired :(
end