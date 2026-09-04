class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!

  rescue_from ActiveRecord::RecordNotFound,             with: :not_found
  rescue_from ActionController::ParameterMissing,       with: :bad_request
  rescue_from ActionDispatch::ParamsParser::ParseError, with: :bad_request

  private

  def not_found
    render json: { error: "Not found" }, status: :not_found
  end

  def bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end