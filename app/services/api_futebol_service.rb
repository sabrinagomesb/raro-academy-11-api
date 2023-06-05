class ApiFutebolService
  def initialize
    @base_url = 'https://api.api-futebol.com.br/v1'
    @auth_header = { Authorization: "Bearer #{Rails.application.credentials.fetch(:api_futebol_key)}" }
  end

  def atualiza_campeonatos!
    campeonatos_api = busca_campeonatos
    campeonatos_api.each do |campeonato_api|
      puts "==> salvando campeonato #{campeonato_api[:nome_popular]}"
      campeonato = salva_campeonato(campeonato_api)
      atualiza_rodadas! campeonato
    end
  end

  def atualiza_rodadas!(campeonato)
    rodadas_api = busca_rodadas campeonato
    rodadas_api.each do |rodada_api|
      puts "====> salvando rodada #{rodada_api[:rodada]} do campeonato #{campeonato.nome}"
      rodada = salva_rodada(campeonato, rodada_api)
      atualiza_jogos!(campeonato, rodada)
    end
  end

  def atualiza_jogos!(campeonato, rodada)
    rodada_api = busca_rodada(campeonato, rodada)
    rodada_api[:partidas].each do |jogo_api|
      puts "======> salvando jogo #{jogo_api[:slug]} da rodada #{rodada.nome} do campeonato #{campeonato.nome}"
      puts "======> - atualiza times"
      puts "======> - atualiza jogos..."
      puts "======> - atualiza placares"
    end
  end

  private
  def busca_campeonatos
    url = "#{@base_url}/campeonatos"
    response = RestClient.get url, @auth_header 
    return JSON.parse(response.body, symbolize_names: true)
  end

  def busca_rodadas(campeonato)
    url = "#{@base_url}/campeonatos/#{campeonato.api_id}/rodadas"
    response = RestClient.get url, @auth_header 
    return JSON.parse(response.body, symbolize_names: true)
  end

  def busca_rodada(campeonato, rodada)
    url = "#{@base_url}/campeonatos/#{campeonato.api_id}/rodadas/#{rodada.api_id}"
    response = RestClient.get url, @auth_header 
    return JSON.parse(response.body, symbolize_names: true)
  end

  def salva_campeonato(campeonato_api)
    campeonato = Campeonato.find_or_initialize_by(api_id: campeonato_api[:campeonato_id])
    campeonato.update!(nome: campeonato_api[:nome_popular], ativo: campeonato_api[:status] != 'encerrado')
    return campeonato
  end

  def salva_rodada(campeonato, rodada_api)
    rodada = Rodada.find_or_initialize_by(api_id: rodada_api[:rodada])
    rodada.update!(campeonato_id: campeonato.id, nome: rodada_api[:nome], ativo: rodada_api[:status] == 'agendada')
    return rodada
  end
end