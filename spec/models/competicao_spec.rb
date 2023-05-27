require 'rails_helper'

RSpec.describe Competicao, type: :model do
  it { should belong_to :usuario } 
  it { should belong_to :campeonato } 
end
