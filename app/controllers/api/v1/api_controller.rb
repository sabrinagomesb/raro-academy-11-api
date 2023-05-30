class Api::V1::ApiController < ApplicationController
  def index
    render json: { message: 'olá mundo' }
  end
end