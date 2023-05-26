require 'rails_helper'

RSpec.describe Jogo, type: :model do
  it { should_not be_valid }

  it { should belong_to(:mandante).class_name('Equipe') }
  it { should belong_to(:visitante).class_name('Equipe') }
  it { should belong_to :rodada }
  it { should have_many :palpites } 
end
