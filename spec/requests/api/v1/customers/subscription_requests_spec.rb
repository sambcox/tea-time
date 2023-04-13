require 'rails_helper'

RSpec.describe 'Customer Subscription Requests' do
  describe 'subscription get requests' do
    let!(:customers) { create_list(:customer, 3)}
    let!(:teas) { create_list(:tea, 6)}
    let!(:subscriptions) { create_list(:subscription, 10)}
    let!(:customer) { Customer.last }
    let!(:tea) { Tea.last }
    let!(:subscription) { Subscription.last }
    it 'can get all subscriptions for a specific customer' do
      get api_v1_customer_subscriptions_path(customer)

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      parsed_response[:data].each do |subscription|
        expect(subscription[:attributes][:customer_id]).to eq(customer.id)
      end
    end

    describe 'sad path/edge case testing' do
      it 'returns an error if the customer is not found' do
        get api_v1_customer_subscriptions_path(999999)

        expect(response.status).to eq 404
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Couldn't find Customer with 'id'=999999")
      end

      it 'returns an empty array if the customer has no subscriptions' do
        customer = create(:customer)
        get api_v1_customer_subscriptions_path(customer)

        expect(response).to be_successful
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:data]).to eq([])
      end
    end
  end
end