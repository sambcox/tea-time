class Api::V1::Customers::SubscriptionsController < ApplicationController
  before_action :set_customer
  def index
    subscriptions = @customer.subscriptions

    render json: SubscriptionSerializer.new(subscriptions)
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end