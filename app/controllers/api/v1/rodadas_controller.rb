class Api::V1::RodadasController < Api::V1::ApiController
  before_action :fetch_rodada, only: [:show]

  def index
    campeonato = current_usuario.campeonatos.find_by_id(params[:campeonato_id])
    if campeonato.nil?
      render json: { error: "Campeonato não encontrado" }, status: :not_found
      return
    end

    render json: campeonato.rodadas
  end

  def show
    render json: @rodada
  end

  private

  def fetch_rodada
    @rodada = current_usuario.campeonatos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Rodada não encontrada" }, status: :not_found
  end
end
