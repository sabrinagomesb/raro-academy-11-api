class Api::V1::CampeonatosController < Api::V1::ApiController
  def index
    if params[:somente_ativos]
      campeonatos = current_usuario.campeonatos.ativos
    else
      campeonatos = current_usuario.campeonatos.all
    end

    render json: campeonatos
  end
end