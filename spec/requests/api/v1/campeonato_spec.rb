require 'rails_helper'

RSpec.describe 'api/v1/campeonato', type: :controller do
  describe Api::V1::CampeonatosController do
    let!(:usuario) { create(:usuario) }

    before :each do
      create(:campeonato)
      create(:campeonato_inativo)

      usuario.campeonatos << Campeonato.all
      usuario.save!

      create(:campeonato)
      sign_in usuario
    end

    it 'Retorna somente os campeonatos do usuário' do
      get :index

      expect(response).to be_successful
      expect(response.body).not_to eq Campeonato.all.to_json
    end

    it 'Retorna todos os campeonatos' do
      get :index

      expect(response).to be_successful
      expect(response.body).to eq usuario.campeonatos.all.to_json
    end

    it 'Retorna todos os campeonatos ativos' do
      get :index, params: { somente_ativos: true }
      expect(response.body).to eq usuario.campeonatos.ativos.to_json
    end
  end
end
