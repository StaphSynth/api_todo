class Api::V1::BaseController < ApplicationController
  before_action :snakecase_params!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  respond_to :json

  private

  def snakecase_params
    params.deep_transform_keys!(&:underscore)
  end

  def record_not_found
    payload = { status: 'error', message: 'record not found' }
    render json: payload, status: :not_found
  end
end
