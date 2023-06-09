class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found(error)
    render json: ErrorSerializer.serialize(Error.new(error)), status: :not_found
  end
end
