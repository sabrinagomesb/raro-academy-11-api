require 'rails_helper'

RSpec.describe Campeonato, type: :model do
  it { should_not be_valid }
  it { should validate_presence_of :nome }
  it { should validate_uniqueness_of(:nome) }

  it { should have_many :rodadas }
  it { should have_many(:competidores).through(:competicoes) } 

  context "busca de campeonatos ativos" do
    before :each do
      create(:campeonato)
      create(:campeonato_inativo)
    end

    it "deve retornar somente os campeonatos ativos" do
      expect(Campeonato.ativos.count).to eq 1
    end
  end
end
