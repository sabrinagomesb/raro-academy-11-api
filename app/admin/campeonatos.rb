ActiveAdmin.register Campeonato do
  scope :all, default: true
  scope :ativos

  collection_action :atualiza_campeonatos, method: :post do
    ApiFutebolService.new.atualiza_campeonatos!
    redirect_to admin_campeonatos_path, notice: 'Campeonatos atualizados com sucesso!'
  end

  action_item :only => :index do
    link_to('Atualiza Campeonatos', atualiza_campeonatos_admin_campeonatos_path, method: :post)
  end
  
  filter :nome
  permit_params :nome, :ativo
end
