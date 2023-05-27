ActiveAdmin.register Rodada do
  filter :campeonato_id, as: :select, collection: Campeonato.all.map{|c| [c.nome, c.id]}
  filter :nome
  filter :ativo

  form do |f|
    inputs do
      input :campeonato_id, as: :select, collection: Campeonato.ativos.map{|c| [c.nome, c.id]}
      input :nome
      input :ativo
    end

    f.has_many :jogos, heading: 'Jogos', allow_destroy: true, new_record: true do |jogo|
      jogo.input :mandante_id, as: :select, collection: Equipe.all.map{|c| [c.nome, c.id]}
      jogo.input :visitante_id, as: :select, collection: Equipe.all.map{|c| [c.nome, c.id]}
      jogo.input :data_hora, as: :datepicker
      jogo.input :gols_mandante
      jogo.input :gols_visitante
    end

    actions
  end
  
  permit_params :nome, :ativo, :campeonato_id, jogos_attributes: [:id, :mandante_id, :visitante_id, :data_hora, :gols_mandante, :gols_visitante, :_destroy]
end
