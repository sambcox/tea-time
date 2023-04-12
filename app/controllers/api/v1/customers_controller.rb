class Api::V1::CustomersController < ApplicationController
  def create
    customer = Customer.create(customer_params)

    if customer.save
      render json: CustomerSerializer.new(customer), status: :created
    else
      render json: ErrorSerializer.serialize(Error.new(customer.errors))
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end