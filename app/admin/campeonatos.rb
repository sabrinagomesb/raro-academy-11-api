ActiveAdmin.register Campeonato do
  scope :all, default: true
  scope :ativos

  filter :nome
  permit_params :nome, :ativo
end
