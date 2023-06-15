require 'rails_helper'

RSpec.describe Jogo, type: :model do
  it { should_not be_valid }

  it { should belong_to(:mandante).class_name('Equipe') }
  it { should belong_to(:visitante).class_name('Equipe') }
  it { should belong_to :rodada }
  it { should have_many :palpites }

  context '#empate?' do
    it 'deve retornar true se o jogo terminou empatado' do
      jogo = Jogo.new gols_mandante: 1, gols_visitante: 1
      expect(jogo.empate?).to be_truthy
    end

    it 'deve retornar false se o jogo não terminou empatado' do
      jogo = Jogo.new gols_mandante: 1, gols_visitante: 0
      expect(jogo.empate?).to be_falsey
    end
  end

  context '#vitoria_mandante?' do
    it 'deve retornar true se o mandante venceu' do
      jogo = Jogo.new gols_mandante: 1, gols_visitante: 0
      expect(jogo.vitoria_mandante?).to be_truthy
    end

    it 'deve retornar false se o mandante não venceu' do
      jogo = Jogo.new gols_mandante: 0, gols_visitante: 1
      expect(jogo.vitoria_mandante?).to be_falsey
    end
  end

  context '#vitoria_visitante?' do
    it 'deve retornar true se o visitante venceu' do
      jogo = Jogo.new gols_mandante: 0, gols_visitante: 1
      expect(jogo.vitoria_visitante?).to be_truthy
    end

    it 'deve retornar false se o visitante não venceu' do
      jogo = Jogo.new gols_mandante: 1, gols_visitante: 0
      expect(jogo.vitoria_visitante?).to be_falsey
    end
  end
end
