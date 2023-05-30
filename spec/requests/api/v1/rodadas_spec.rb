require 'rails_helper'

RSpec.describe 'api/v1/campeonatos/:id/rodadas', type: :controller do
  describe Api::V1::RodadasController do
    before :each do
      usuario = create(:usuario)
      rodada = create(:rodada)
      usuario.campeonatos << rodada.campeonato
      usuario.save!

      sign_in usuario
    end

    it "retorna todas as rodadas do campeonato que o usuário está competindo" do
      get :index, params: { campeonato_id: Campeonato.first.id }
      expect(response.body).to eq(Rodada.all.to_json)
    end
    
    it "retorna status 404 se o usuário não compete no campeonato" do
      get :index, params: { campeonato_id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
