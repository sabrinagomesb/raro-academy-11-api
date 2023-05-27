ActiveAdmin.register Competicao do
  form do |f|
    inputs do
      input :campeonato_id, as: :select, collection: Campeonato.ativos.map{|c| [c.nome, c.id]}
      input :usuario_id, as: :select, collection: Usuario.all.map{|c| [c.to_s, c.id]}
    end

    actions
  end

  permit_params :usuario_id, :campeonato_id
end
