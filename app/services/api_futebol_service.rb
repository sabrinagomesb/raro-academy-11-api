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
end