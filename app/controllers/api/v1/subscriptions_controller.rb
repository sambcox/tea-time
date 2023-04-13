class Api::V1::SubscriptionsController < ApplicationController
  def create
    tea = Tea.find(subscription_params[:tea_id])
    customer = Customer.find(subscription_params[:customer_id])

    subscription = tea.subscriptions.create(subscription_params)

    if subscription.save
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: ErrorSerializer.serialize(Error.new(subscription.errors))
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end