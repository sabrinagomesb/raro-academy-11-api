require 'rails_helper'

RSpec.describe 'api/v1/campeonatos/:campeonato_id/rodadas/:rodada_id/palpites', type: :controller do
  describe Api::V1::PalpitesController do
    let!(:rodada) { create(:rodada) }
    let!(:usuario) { create(:usuario) }
    let!(:outro_usuario) { create(:usuario) }

    before :each do
      usuario.campeonatos << rodada.campeonato
      usuario.save!

      sign_in usuario
    end

    it 'deve retornar todos os palpites da rodada para o usuário' do
      jogo = create(:jogo, rodada: rodada)
      palpite = create(:palpite, jogo: jogo, usuario: usuario)

      get :index, params: { campeonato_id: rodada.campeonato.id, rodada_id: rodada.id }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(1)
      expect(body[0]['jogo_id']).to eq(jogo.id)
      expect(body[0]['gols_mandante']).to eq(palpite.gols_mandante)
      expect(body[0]['gols_visitante']).to eq(palpite.gols_visitante)
    end

    it 'retorna status 400 se a rodada não estiver ativa' do
      rodada.update(ativo: false)

      get :index, params: { campeonato_id: rodada.campeonato.id, rodada_id: rodada.id }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('A rodada ainda não foi iniciada')
    end

    it 'cria palpites para os jogos fornecidos' do
      jogos = create_list(:jogo, 2, rodada: rodada)
      palpites_params = [
        { jogo_id: jogos[0].id, gols_mandante: 1, gols_visitante: 2 },
        { jogo_id: jogos[1].id, gols_mandante: 0, gols_visitante: 0 }
      ]

      post :create_or_update, params: { campeonato_id: rodada.campeonato.id, rodada_id: rodada.id, palpites: palpites_params }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Palpites criados/atualizados com sucesso')

      expect(Palpite.count).to eq(2)
      expect(Palpite.where(jogo_id: jogos[0].id, usuario_id: usuario.id).first.gols_mandante).to eq(1)
      expect(Palpite.where(jogo_id: jogos[0].id, usuario_id: usuario.id).first.gols_visitante).to eq(2)
      expect(Palpite.where(jogo_id: jogos[1].id, usuario_id: usuario.id).first.gols_mandante).to eq(0)
      expect(Palpite.where(jogo_id: jogos[1].id, usuario_id: usuario.id).first.gols_visitante).to eq(0)
    end

    it 'atualiza palpites existentes' do
      jogo = create(:jogo, rodada: rodada)
      palpite = create(:palpite, jogo: jogo, usuario: usuario)

      put :create_or_update, params: { campeonato_id: rodada.campeonato.id, rodada_id: rodada.id, palpites: [{ jogo_id: jogo.id, gols_mandante: 2, gols_visitante: 1 }] }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Palpites criados/atualizados com sucesso')

      expect(Palpite.count).to eq(1)
      expect(palpite.reload.gols_mandante).to eq(2)
      expect(palpite.reload.gols_visitante).to eq(1)
    end

    it 'retorna status 400 se a rodada não estiver ativa ao criar palpites' do
      rodada.update(ativo: false)

      post :create_or_update, params: { campeonato_id: rodada.campeonato.id, rodada_id: rodada.id, palpites: [{ jogo_id: 1, gols_mandante: 1, gols_visitante: 2 }] }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('A rodada ainda não foi iniciada')
    end

    it 'retorna status 400 se a rodada não estiver ativa ao criar palpites' do
      rodada.update(ativo: false)

      put :create_or_update, params: { campeonato_id: rodada.campeonato.id, rodada_id: rodada.id, palpites: [{ jogo_id: 1, gols_mandante: 2, gols_visitante: 1 }] }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('A rodada ainda não foi iniciada')
    end
  end
end
