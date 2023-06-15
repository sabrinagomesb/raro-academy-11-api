# frozen_string_literal: true

module Api
  module V1
    class PalpitesController < Api::V1::ApiController
      before_action :fetch_rodada, only: %i[index create_or_update]
      before_action :verify_rodada_ativa, only: %i[index create_or_update]

      def index
        palpites = []

        @rodada.jogos.each do |jogo|
          palpite = Palpite.find_by(jogo_id: jogo.id, usuario_id: current_usuario.id)

          palpites << if palpite
                        {
                          jogo_id: jogo.id,
                          gols_mandante: palpite.gols_mandante,
                          gols_visitante: palpite.gols_visitante
                        }
                      else
                        {
                          jogo_id: jogo.id,
                          gols_mandante: nil,
                          gols_visitante: nil
                        }
                      end
        end

        render json: palpites, status: :ok
      end

      def create_or_update
        params[:palpites].each do |palpite_params|
          palpite = Palpite.find_or_initialize_by(jogo_id: palpite_params[:jogo_id], usuario_id: current_usuario.id)
          palpite.assign_attributes(palpite_params.permit(:gols_mandante, :gols_visitante))
          palpite.save
        end

        render json: { message: 'Palpites criados/atualizados com sucesso' }, status: :ok
      end

      private

      def palpite_params
        params.require(:palpite).permit(:jogo_id, :gols_mandante, :gols_visitante)
      end

      def fetch_rodada
        @rodada = Rodada.find(params[:rodada_id])

        return render json: { error: 'Rodada não encontrada' }, status: :not_found unless @rodada
      end

      def verify_rodada_ativa
        return if @rodada.ativo?

        render json: { error: 'A rodada ainda não foi iniciada' }, status: :bad_request
      end
    end
  end
end
