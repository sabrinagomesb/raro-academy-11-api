require 'rails_helper'

RSpec.describe Rodada, type: :model do
  it { should_not be_valid }
  it { should validate_presence_of :nome }
  it { should belong_to :campeonato }
end
