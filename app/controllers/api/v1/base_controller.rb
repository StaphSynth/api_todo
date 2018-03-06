class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    payload = { status: 'error', message: 'record not found' }
    render json: payload, status: :not_found
  end
end
