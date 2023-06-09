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

    describe 'sad path/edge case testing' do
      it 'will return an error if title is not given' do
        subscription_params = {
          price: Faker::Number.decimal(l_digits: 2),
          frequency: Faker::Number.between(from: 1, to: 52),
          customer_id: customer.id,
          tea_id: tea.id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Title can't be blank")
      end

      it 'will return an error if price is not given' do
        subscription_params = {
          title: Faker::Vehicle.manufacture,
          frequency: Faker::Number.between(from: 1, to: 52),
          customer_id: customer.id,
          tea_id: tea.id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Price can't be blank")
      end

      it 'will return an error if frequency is not given' do
        subscription_params = {
          title: Faker::Vehicle.manufacture,
          price: Faker::Number.decimal(l_digits: 2),
          customer_id: customer.id,
          tea_id: tea.id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Frequency can't be blank")
      end

      it 'will return an error if customer ID is not given' do
        subscription_params = {
          title: Faker::Vehicle.manufacture,
          price: Faker::Number.decimal(l_digits: 2),
          frequency: Faker::Number.between(from: 1, to: 52),
          tea_id: tea.id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

        expect(response.status).to eq 404
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Couldn't find Customer without an ID")
      end

      it 'will return an error if tea ID is not given' do
        subscription_params = {
          title: Faker::Vehicle.manufacture,
          price: Faker::Number.decimal(l_digits: 2),
          frequency: Faker::Number.between(from: 1, to: 52),
          customer_id: customer.id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

        expect(response.status).to eq 404
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Couldn't find Tea without an ID")
      end
    end
  end

  describe 'subscription patch requests' do
    let!(:customers) { create_list(:customer, 3)}
    let!(:teas) { create_list(:tea, 6)}
    let!(:subscriptions) { create_list(:subscription, 10)}
    let!(:customer) { Customer.last }
    let!(:tea) { Tea.last }
    let!(:subscription) { Subscription.last }
    it 'can change a subscription to be inactive' do
      subscription_params = {
        status: 'inactive'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(subscription_params)

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:status]).to eq('inactive')

      subscription.reload

      expect(subscription.status).to eq('inactive')
    end

    describe 'sad paths/edge cases' do
      it 'will not update if status is not given' do
        subscription_params = {
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(subscription_params)

        expect(response).to be_successful
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:data][:attributes][:status]).to eq('active')

        subscription.reload

        expect(subscription.status).to eq('active')
      end

      it 'will return an error if status is not active or inactive' do
        subscription_params = {
          status: 'gobbledegook'
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(subscription_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Status gobbledegook is not a valid status")
      end
    end
  end
end