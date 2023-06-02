namespace :atualiza_campeonatos do
  desc "Atualiza campeonatos"
  task atualiza: :environment do
    cliente = ApiFutebolService.new
    cliente.atualiza_campeonatos!
  end
end
