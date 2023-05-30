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
end
