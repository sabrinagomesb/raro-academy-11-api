require 'rails_helper'

RSpec.describe Palpite, type: :model do
  it { should belong_to :jogo }
  it { should belong_to :usuario }
  it { should validate_presence_of :gols_mandante }
  it { should validate_presence_of :gols_visitante }

  describe 'scope .do_usuario' do
    let!(:usuario_1) { create(:usuario) }
    let!(:usuario_2) { create(:usuario) }

    let!(:palpite_1) { create(:palpite, usuario: usuario_1) }
    let!(:palpite_2) { create(:palpite, usuario: usuario_2) }

    it 'deve filtrar palpites a partir do usuário' do
      expect(Palpite.do_usuario(usuario_1.id)).to include palpite_1
      expect(Palpite.do_usuario(usuario_1.id)).not_to include palpite_2
    end
  end

  describe 'scope .da_rodada' do
    let!(:jogo) { create(:jogo) }
    let!(:palpite_1) { create(:palpite, jogo: jogo) }
    let!(:palpite_2) { create(:palpite, jogo: jogo) }
    let!(:palpite_3) { create(:palpite) }

    it 'deve filtrar palpites a partir da rodada' do
      expect(Palpite.da_rodada(palpite_1.jogo.rodada.id)).to include palpite_1
      expect(Palpite.da_rodada(palpite_1.jogo.rodada.id)).to include palpite_2
      expect(Palpite.da_rodada(palpite_1.jogo.rodada.id)).not_to include palpite_3
    end
  end

  describe '#empate?' do
    let!(:palpite) { create(:palpite, gols_mandante: 1, gols_visitante: 1) }

    it 'deve retornar true se o palpite for de empate' do
      expect(palpite.empate?).to be true
    end

    it 'deve retornar false se o palpite não for de empate' do
      palpite.gols_mandante = 2
      expect(palpite.empate?).to be false
    end
  end

  describe '#vitoria_mandante?' do
    let!(:palpite) { create(:palpite, gols_mandante: 2, gols_visitante: 1) }

    it 'deve retornar true se o palpite for de vitória do mandante' do
      expect(palpite.vitoria_mandante?).to be true
    end

    it 'deve retornar false se o palpite não for de vitória do mandante' do
      palpite.gols_mandante = 1
      expect(palpite.vitoria_mandante?).to be false
    end
  end

  describe '#vitoria_visitante?' do
    let!(:palpite) { create(:palpite, gols_mandante: 1, gols_visitante: 2) }

    it 'deve retornar true se o palpite for de vitória do visitante' do
      expect(palpite.vitoria_visitante?).to be true
    end

    it 'deve retornar false se o palpite não for de vitória do visitante' do
      palpite.gols_visitante = 1
      expect(palpite.vitoria_visitante?).to be false
    end
  end

  describe '#acertou_gols_mandante?' do
    let!(:jogo) { create(:jogo, gols_mandante: 1, gols_visitante: 2) }
    let!(:palpite) { create(:palpite, gols_mandante: 1, gols_visitante: 2, jogo: jogo) }

    it 'deve retornar true se o palpite acertou os gols do mandante' do
      expect(palpite.acertou_gols_mandante?(palpite.jogo)).to be true
    end

    it 'deve retornar false se o palpite não acertou os gols do mandante' do
      palpite.gols_mandante = 2
      expect(palpite.acertou_gols_mandante?(palpite.jogo)).to be false
    end
  end

  describe '#acertou_gols_visitante?' do
    let!(:jogo) { create(:jogo, gols_mandante: 1, gols_visitante: 2) }
    let!(:palpite) { create(:palpite, gols_mandante: 1, gols_visitante: 2, jogo: jogo) }

    it 'deve retornar true se o palpite acertou os gols do visitante' do
      expect(palpite.acertou_gols_visitante?(palpite.jogo)).to be true
    end

    it 'deve retornar false se o palpite não acertou os gols do visitante' do
      palpite.gols_visitante = 1
      expect(palpite.acertou_gols_visitante?(palpite.jogo)).to be false
    end
  end
end
