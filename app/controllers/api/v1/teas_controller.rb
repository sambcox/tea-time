class Api::V1::TeasController < ApplicationController
  def create
    tea = Tea.create(tea_params)

    if tea.save
      render json: TeaSerializer.new(tea), status: :created
    else
      render json: ErrorSerializer.serialize(Error.new(tea.errors)), status: :unprocessable_entity
    end
  end

  private

  def tea_params
    params.permit(:title, :description, :temperature, :brew_time)
  end
end