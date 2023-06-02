require 'rails_helper'

RSpec.describe 'api/v1/campeonato/{:campeonato_id}/rodadas', type: :controller do
  describe Api::V1::RodadasController do
    let!(:usuario) { create(:usuario) }
    let!(:rodada) { create(:rodada) }
    let!(:campeonato) { create(:campeonato) }

    before :each do
      usuario.campeonatos << rodada.campeonato
      usuario.save!

      sign_in usuario
    end

    it 'Retorna todas as rodadas do campeonato' do
      get :index, params: { campeonato_id: rodada.campeonato.id }
      expect(response).to be_successful

      expect(response.body).to eq(Rodada.all.to_json)
    end

    it 'retorna status 404 quando não encontra o campeonato' do
      get :index, params: { campeonato_id: campeonato.id }
      expect(response).to have_http_status(:not_found)
    end
  end
end
