require 'rails_helper'
require 'faker'

RSpec.describe Usuario, type: :model do
  it { should_not be_valid }
  it { should have_many :palpites }
  it { should have_many :competicoes }
  it { should have_many(:campeonatos).through(:competicoes) }

  context "criacao do usuario" do
    it "email e senha são obrigatórios" do
      usuario = Usuario.new email: Faker::Internet.email, password: Faker::Internet.password, nome: Faker::Name.name
      expect(usuario).to be_valid
    end

    it "valida formato de email" do
      usuario = Usuario.new email: Faker::Name.name, password: Faker::Internet.password, nome: Faker::Name.name
      expect(usuario).to_not be_valid
    end

    it "valida presença de senha" do
      usuario = Usuario.new email: Faker::Internet.email, nome: Faker::Name.name
      expect(usuario).to_not be_valid
    end

    it "valida presença de nome" do
      usuario = Usuario.new email: Faker::Internet.email, password: Faker::Internet.password
      expect(usuario).to_not be_valid
    end
  end

  context 'pontuacao' do
    let!(:campeonato) { create(:campeonato) }
    let!(:usuario) { create(:usuario) }
    let!(:rodada) { create(:rodada, campeonato: campeonato) }
    let!(:jogo) { create(:jogo, rodada: rodada, gols_mandante: 0, gols_visitante: 0) }
    let!(:palpite) { create(:palpite, jogo: jogo, usuario: usuario, gols_mandante: 0, gols_visitante: 0) }

    it 'deve retornar a pontuacao completa do usuario no campeonato' do
      expect(usuario.pontuacao(campeonato)).to eq 6
    end

    it 'deve retornar a pontuação de errar todas as possibilidades do usuario no campeonato' do
      palpite.update gols_mandante: 1, gols_visitante: 3
      expect(usuario.pontuacao(campeonato)).to eq 0
    end

    it 'deve retornar a pontuacao acerto de emptate do usuario no campeonato' do
      palpite.update gols_mandante: 1, gols_visitante: 1
      expect(usuario.pontuacao(campeonato)).to eq 3
    end

    it 'deve retornar a pontuacao acerto de vitoria do usuario no campeonato' do
      jogo.update gols_mandante: 2, gols_visitante: 1
      palpite.update gols_mandante: 3, gols_visitante: 1
      expect(usuario.pontuacao(campeonato)).to eq 3
    end

    it 'deve retornar a pontuacao acerto de derrota do usuario no campeonato' do
      jogo.update gols_mandante: 1, gols_visitante: 3
      palpite.update gols_mandante: 0, gols_visitante: 1
      expect(usuario.pontuacao(campeonato)).to eq 3
    end

    it 'deve retornar a pontuacao de não palpitar do usuario no campeonato' do
      jogo.update gols_mandante: 1, gols_visitante: 3
      palpite.destroy
      expect(usuario.pontuacao(campeonato)).to eq -1
    end
  end
end
