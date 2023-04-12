require 'rails_helper'

RSpec.describe 'Customer Requests' do
  describe 'customer post requests' do
    it 'can create a customer' do
      customer_params = {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        address: Faker::Address.full_address
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post api_v1_customers_path, headers: headers, params: JSON.generate(customer_params)

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:first_name]).to eq(customer_params[:first_name])
      expect(parsed_response[:data][:attributes][:last_name]).to eq(customer_params[:last_name])
      expect(parsed_response[:data][:attributes][:email]).to eq(customer_params[:email])
      expect(parsed_response[:data][:attributes][:address]).to eq(customer_params[:address])

      created_customer = Customer.last

      expect(created_customer.first_name).to eq(customer_params[:first_name])
      expect(created_customer.last_name).to eq(customer_params[:last_name])
      expect(created_customer.email).to eq(customer_params[:email])
      expect(created_customer.address).to eq(customer_params[:address])
    end
  end
end