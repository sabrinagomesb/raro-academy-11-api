require 'rails_helper'

RSpec.describe 'api/v1/campeonatos/:campeonato_id/rodadas/:rodada_id/jogos', type: :controller do
  describe Api::V1::JogosController do
    let!(:jogo_1) { create(:jogo) }
    let!(:jogo_2) { create(:jogo, rodada: jogo_1.rodada) }
    let!(:outro_jogo) { create(:jogo) }
    let!(:usuario) { create(:usuario) }
    let!(:outro_usuario) { create(:usuario) }
    let!(:palpite) { create(:palpite, usuario: usuario, jogo: jogo_1) }
    let!(:outro_palpite) { create(:palpite, usuario: outro_usuario, jogo: jogo_1) }
    
    before :each do
      usuario.campeonatos << jogo_1.rodada.campeonato
      usuario.save!

      sign_in usuario
    end

    it "deve retornar todas as jogos da rodada somente com o palpite do usuario" do
      rodada = jogo_1.rodada
      campeonato = rodada.campeonato
      get :index, params: { campeonato_id: campeonato.id, rodada_id: rodada.id }

      body = JSON.parse response.body
      expect(body.size).to eq(2)
      expect(body[0]['id']).to eq(jogo_1.id)
      expect(body[0]['mandante']['nome']).to eq(jogo_1.mandante.nome)
      expect(body[0]['palpite'].present?).to be_truthy
    end
    
    it "deve retornar status 404 se o usuário não compete no campeonato" do
      rodada = outro_jogo.rodada
      campeonato = rodada.campeonato
      get :index, params: { campeonato_id: campeonato.id, rodada_id: rodada.id }
      expect(response.status).to eq 404
    end
  end
end
