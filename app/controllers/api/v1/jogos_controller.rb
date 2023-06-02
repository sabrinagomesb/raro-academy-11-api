class Api::V1::JogosController < Api::V1::ApiController
  before_action :busca_rodada, only: [:index]

  def index
    @jogos = @rodada.jogos.includes(:mandante, :visitante)
    @palpites = Palpite.do_usuario(current_usuario.id).da_rodada(@rodada.id)
    
    @jogos.each do |jogo|
      jogo.palpite = @palpites.to_a.find { |p| p.jogo_id == jogo.id }
    end

    render json: @jogos.to_json(include: [:palpite, :mandante, :visitante])
  end

  private
  def busca_rodada
    campeonato = current_usuario.campeonatos.find_by_id(params[:campeonato_id])
    @rodada = campeonato&.rodadas&.find_by_id(params[:rodada_id])
    if @rodada.nil?
      render json: { error: 'Rodada não encontrado' }, status: :not_found
      return
    end
  end
end
