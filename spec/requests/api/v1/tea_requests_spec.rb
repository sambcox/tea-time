require 'rails_helper'

RSpec.describe 'Tea Requests' do
  describe 'tea post requests' do
    it 'can create a tea' do
      tea_params = {
        title: Faker::Tea.variety,
        description: Faker::Tea.type,
        temperature: Faker::Number.between(from: 150, to: 400),
        brew_time: Faker::Number.between(from: 5, to: 15)
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post api_v1_teas_path, headers: headers, params: JSON.generate(tea_params)

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:title]).to eq(tea_params[:title])
      expect(parsed_response[:data][:attributes][:description]).to eq(tea_params[:description])
      expect(parsed_response[:data][:attributes][:temperature]).to eq(tea_params[:temperature])
      expect(parsed_response[:data][:attributes][:brew_time]).to eq(tea_params[:brew_time])

      created_tea = Tea.last

      expect(created_tea.title).to eq(tea_params[:title])
      expect(created_tea.description).to eq(tea_params[:description])
      expect(created_tea.temperature).to eq(tea_params[:temperature])
      expect(created_tea.brew_time).to eq(tea_params[:brew_time])
    end

    describe 'sad path/edge case testing' do
      it 'will return an error if title is not given' do
        tea_params = {
          description: Faker::Tea.type,
          temperature: Faker::Number.between(from: 150, to: 400),
          brew_time: Faker::Number.between(from: 5, to: 15)
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_teas_path, headers: headers, params: JSON.generate(tea_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Title can't be blank")
      end

      it 'will return an error if description is not given' do
        tea_params = {
          title: Faker::Tea.variety,
          temperature: Faker::Number.between(from: 150, to: 400),
          brew_time: Faker::Number.between(from: 5, to: 15)
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_teas_path, headers: headers, params: JSON.generate(tea_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Description can't be blank")
      end

      it 'will return an error if temperature is not given' do
        tea_params = {
          title: Faker::Tea.variety,
          description: Faker::Tea.type,
          brew_time: Faker::Number.between(from: 5, to: 15)
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_teas_path, headers: headers, params: JSON.generate(tea_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Temperature can't be blank")
      end

      it 'will return an error if brew time is not given' do
        tea_params = {
          title: Faker::Tea.variety,
          description: Faker::Tea.type,
          temperature: Faker::Number.between(from: 150, to: 400)
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_teas_path, headers: headers, params: JSON.generate(tea_params)

        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].first).to eq("Brew time can't be blank")
      end
    end
  end
end