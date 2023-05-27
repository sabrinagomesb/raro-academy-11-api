ActiveAdmin.register Palpite do
  actions :index
  
  filter :usuario_id, as: :select, collection: Usuario.all.map{|c| [c.email, c.id]}
  filter :jogo_id, as: :select, collection: Jogo.all.map{|c| [c.nome, c.id]}  

  index do
    column :rodada
    column :mandante
    column :visitante
    column :gols_mandante
    column :gols_visitante
  end
end
