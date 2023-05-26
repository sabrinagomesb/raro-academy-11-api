require 'rails_helper'

RSpec.describe Palpite, type: :model do
  it { should belong_to :jogo } 
  it { should belong_to :usuario } 
  it { should validate_presence_of :gols_mandante }
  it { should validate_presence_of :gols_visitante }
end
