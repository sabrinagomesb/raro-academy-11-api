class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_default_format
  before_action :authenticate_usuario!

  def index
    render json: { message: 'olá mundo' }
  end

  private
  def set_default_format
    request.format = :json
  end
end