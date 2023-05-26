require 'rails_helper'
require 'faker'

RSpec.describe Usuario, type: :model do
  it { should_not be_valid }

  context "criacao do usuario" do
    it "email e senha são obrigatórios" do
      usuario = Usuario.new email: Faker::Internet.email, password: Faker::Internet.password
      expect(usuario).to be_valid
    end

    it "valida formato de email" do
      usuario = Usuario.new email: Faker::Name.name, password: Faker::Internet.password
      expect(usuario).to_not be_valid
    end

    it "valida presença de senha" do
      usuario = Usuario.new email: Faker::Internet.email
      expect(usuario).to_not be_valid
    end
  end
end
