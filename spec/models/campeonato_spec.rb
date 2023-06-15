require 'rails_helper'

RSpec.describe Campeonato, type: :model do
  it { should_not be_valid }
  it { should validate_presence_of :nome }
  it { should validate_uniqueness_of(:nome) }

  it { should have_many :rodadas }
  it { should have_many(:competidores).through(:competicoes) }

  context "busca de campeonatos ativos" do
    it "deve retornar somente os campeonatos ativos" do
      Campeonato.create! nome: "Campeonato 1", ativo: true
      Campeonato.create! nome: "Campeonato 2", ativo: false

      expect(Campeonato.ativos.count).to eq 1
    end
  end

  context "#ranking" do
    let!(:campeonato) { create(:campeonato) }

    let!(:usuario_1) { create(:usuario) }
    let(:usuario_2) { create(:usuario) }

    let!(:rodada) { create(:rodada, campeonato: campeonato) }
    let!(:jogo) { create(:jogo, rodada: rodada, gols_mandante: 1, gols_visitante: 0) }

    let!(:competicao_1) { create(:competicao, campeonato: campeonato, usuario: usuario_1) }
    let!(:competicao_2) { create(:competicao, campeonato: campeonato, usuario: usuario_2) }

    let!(:palpite_1) { create(:palpite, jogo: jogo, usuario: usuario_1, gols_mandante: 1, gols_visitante: 0) }
    let!(:palpite_2) { create(:palpite, jogo: jogo, usuario: usuario_2, gols_mandante: 1, gols_visitante: 3) }

    let!(:ranking) { campeonato.ranking }

    it 'deve retornar o ranking de um campeonato' do
      expect(ranking.count).to eq 2
    end

    it 'deve retornar o ranking com a pontuação' do
      expect(ranking.first[:pontuacao]).to eq 6
      expect(ranking.last[:pontuacao]).to eq 0
    end

    it 'deve retornar o ranking com o nome' do
      expect(ranking.first[:nome]).to eq usuario_1.nome
      expect(ranking.last[:nome]).to eq usuario_2.nome
    end

    it 'deve retornar o ranking com o id' do
      expect(ranking.first[:id]).to eq usuario_1.id
      expect(ranking.last[:id]).to eq usuario_2.id
    end
  end
end
