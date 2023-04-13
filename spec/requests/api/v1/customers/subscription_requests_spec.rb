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
  end
end