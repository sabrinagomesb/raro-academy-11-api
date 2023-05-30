class Api::V1::RodadasController < Api::V1::ApiController
  def index
    campeonato = current_usuario.campeonatos.find_by_id(params[:campeonato_id])
    if campeonato.nil?
      render json: { error: 'Campeonato não encontrado' }, status: :not_found
      return
    end

    render json: campeonato.rodadas
  end
end