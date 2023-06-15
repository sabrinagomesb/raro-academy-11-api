require 'rest-client'

class ApiFutebolService
  def initialize
    @base_url = 'https://api.api-futebol.com.br/v1'
    @auth_header = { Authorization: "Bearer #{Rails.application.credentials.fetch(:api_futebol_api_key)}" }
  end

  def atualiza_campeonatos!
    puts "inicia busca de campeonatos"
    campeonatos_api = fetch_campeonatos
    campeonatos_api.each do |campeonato_api|
      puts "atualiza dados do campeonato #{campeonato_api[:campeonato_id]}"
      campeonato = salvar_campeonato(campeonato_api)
      atualiza_rodadas! campeonato
    end
  end

  def atualiza_rodadas! campeonato
    puts "    inicia busca de campeonatos"
    rodadas_api = fetch_rodadas(campeonato)
    rodadas_api.each do |rodada_api|
      puts "    atualiza dados da rodada #{rodada_api[:rodada]}"
      rodada = salvar_rodada(campeonato, rodada_api)
      atualiza_jogos!(campeonato, rodada)
    end
  end

  def atualiza_jogos!(campeonato, rodada)
    puts "        salvar jogos"
    jogos_api = fetch_jogos(campeonato, rodada)
    jogos_api.each do |jogo_api|
      puts "        atualiza dados do jogo #{jogo_api[:jogo_id]}"
      time_mandante = atualiza_time!(jogo_api[:time_mandante])
      time_visitante = atualiza_time!(jogo_api[:time_visitante])
      salvar_jogo(campeonato, rodada, jogo_api, time_mandante, time_visitante)
    end
  end

  def atualiza_time!(time_api)
    puts "            salvar times"

    time = fetch_time(time_api[:time_id])
    salvar_time(time)
  end

  private

  def fetch_campeonatos
    url = "#{@base_url}/campeonatos"
    response = RestClient.get url, @auth_header
    return JSON.parse(response.body, symbolize_names: true)
  end

  def salvar_campeonato dto
    campeonato = Campeonato.find_or_initialize_by(api_id: dto[:campeonato_id])
    campeonato.update!(nome: dto[:nome], ativo: dto[:status] == 'encerrado')
    return campeonato
  end

  def fetch_rodadas(campeonato)
    url = "#{@base_url}/campeonatos/#{campeonato.id}/rodadas"
    response = RestClient.get url, @auth_header
    return JSON.parse(response.body, symbolize_names: true)
  end

  def salvar_rodada campeonato, rodada_dto
    rodada = Rodada.find_or_initialize_by(api_id: rodada_dto[:rodada])
    rodada.update!(campeonato_id: campeonato.id, nome: rodada_dto[:nome], ativo: rodada_dto[:status] != 'encerrada')
    return rodada
  end

  def fetch_jogos(campeonato, rodada)
    url = "#{@base_url}/campeonatos/#{campeonato.id}/rodadas/#{rodada.id}"
    response = RestClient.get url, @auth_header
    rodada = JSON.parse(response.body, symbolize_names: true)
    return rodada[:partidas]
  end

  def salvar_jogo(campeonato, rodada, jogo_dto, time_mandante, time_visitante)
    jogo = Jogo.find_or_initialize_by(api_id: jogo_dto[:jogo_id])
    jogo.update!(
        rodada_id: rodada.id,
        ativo: jogo_dto[:status] != 'encerrado',
        mandante: time_mandante,
        visitante: time_visitante,
        gols_mandante: jogo_dto[:placar_mandante],
        gols_visitante: jogo_dto[:placar_visitante],
        data_hora: jogo_dto[:data_realizacao_iso])
    return jogo
  end

  def fetch_time(equipe)
    url = "#{@base_url}/times/#{equipe}"
    response = RestClient.get url, @auth_header
    return JSON.parse(response.body, symbolize_names: true)
  end

  def salvar_time(equipe_dto)
    time = Equipe.find_or_initialize_by(api_id: equipe_dto[:time_id])
    time.update!(nome: equipe_dto[:nome_popular])
    return time
  end
end
