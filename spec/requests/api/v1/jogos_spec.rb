require 'rails_helper'

RSpec.describe 'api/v1/campeonato/{:campeonato_id}/rodadas/{:rodada_id}/jogos', type: :controller do
  describe Api::V1::JogosController do
    let!(:jogo_1) { create(:jogo) }
    let!(:jogo_2) { create(:jogo, rodada: jogo_1.rodada) }
    let!(:jogo_3) { create(:jogo, rodada: jogo_1.rodada) }
    let!(:outro_jogo) { create(:jogo) }
    let!(:usuario) { create(:usuario) }
    let!(:outro_usuario) { create(:usuario) }
    let!(:palpite) { create(:palpite, usuario: usuario, jogo: jogo_1) }
    let!(:palpite_2) { create(:palpite, usuario: usuario, jogo: jogo_2) }
    let!(:outro_palpite) { create(:palpite, usuario: outro_usuario, jogo: jogo_1) }
    let!(:outro_campeonato) { create(:campeonato) }

    before :each do
      usuario.campeonatos << jogo_1.rodada.campeonato
      usuario.save!

      sign_in usuario
    end

    describe 'requisicoes com sucesso' do
      before :each do
        rodada = jogo_1.rodada
        campeonato = rodada.campeonato
        get :index, params: { campeonato_id: campeonato.id, rodada_id: rodada.id }
      end

      it 'deve retornar todos os jogos com o palpite do usuario caso exista palpite' do
        jogos = JSON.parse response.body
        expect(response).to be_successful
        expect(response).to have_http_status 200
        expect(jogos[0]['palpite'].present?).to be_truthy
      end
  
      it 'deve retornar o mandante e o visitante do jogo na resposta' do
        jogos = JSON.parse response.body
        expect(response).to be_successful
        expect(response).to have_http_status 200
        expect(jogos[0]['mandante'].present?).to be_truthy
        expect(jogos[0]['visitante'].present?).to be_truthy
      end
    
      it 'deve retornar todos os jogos sem palpites do usuario caso eles não existam' do
        jogos = JSON.parse response.body
        expect(response).to be_successful
        expect(response).to have_http_status 200
        expect(jogos[2]['palpite'].present?).not_to be_truthy
      end
    
      it 'não deve exibir o palpite de outro usuário para o usuário logado' do
        jogos = JSON.parse response.body
        expect(response).to be_successful
        expect(response).to have_http_status 200
        expect(jogos[0]['palpite']['id']).not_to eq(outro_palpite.id)
        expect(jogos[0]['palpites'].present?).not_to be_truthy
      end
    end

    describe 'requisicoes com 404' do
      it 'deve retornar um 404 se o campeonato não existe' do
        get :index, params: { campeonato_id: 0, rodada_id: 0 }
        expect(response).to have_http_status 404
      end

      it 'deve retornar um 404 se a rodada não existe' do
        rodada = jogo_1.rodada
        campeonato = rodada.campeonato 
        get :index, params: { campeonato_id: campeonato.id, rodada_id: 0 }
        expect(response).to have_http_status 404
      end


      it 'deve retornar um 404 se o campeonato não existe na lista do usuario' do
        rodada = jogo_1.rodada
        get :index, params: { campeonato_id: outro_campeonato.id, rodada_id: 0 }
        expect(response).to have_http_status 404
      end
    end
  end
end
