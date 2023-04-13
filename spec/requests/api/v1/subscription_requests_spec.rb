require 'rails_helper'

RSpec.describe 'Subscription Requests' do
  describe 'subscription post requests' do
    let!(:customers) { create_list(:customer, 3)}
    let!(:teas) { create_list(:tea, 6)}
    let!(:customer) { Customer.last }
    let!(:tea) { Tea.last }
    it 'can create a subscription' do
      subscription_params = {
        title: Faker::Vehicle.manufacture,
        price: Faker::Number.decimal(l_digits: 2),
        frequency: Faker::Number.between(from: 1, to: 52),
        customer_id: customer.id,
        tea_id: tea.id
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:title]).to eq(subscription_params[:title])
      expect(parsed_response[:data][:attributes][:price]).to eq(subscription_params[:price])
      expect(parsed_response[:data][:attributes][:status]).to eq('active')
      expect(parsed_response[:data][:attributes][:frequency]).to eq(subscription_params[:frequency])

      created_subscription = Subscription.last

      expect(created_subscription.title).to eq(subscription_params[:title])
      expect(created_subscription.price).to eq(subscription_params[:price])
      expect(created_subscription.status).to eq('active')
      expect(created_subscription.frequency).to eq(subscription_params[:frequency])
      expect(created_subscription.customer.id).to eq(subscription_params[:customer_id])
      expect(created_subscription.tea.id).to eq(subscription_params[:tea_id])
    end
  end
end