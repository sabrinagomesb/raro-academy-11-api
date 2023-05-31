class Api::V1::CampeonatosController < Api::V1::ApiController
  def index
    if params[:somente_ativos]
      campeonatos = current_usuario.campeonatos.ativos
    else
      campeonatos = current_usuario.campeonatos.all
    end

    render json: campeonatos
  end

  def create
    cliente = ApiFutebolService.new
    cliente.atualiza_campeonatos!

    head :no_content
  end
end