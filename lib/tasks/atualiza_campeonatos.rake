namespace :atualiza_campeonatos do
  desc "Atualiza campeonatos"
  task atualiza: :environment do
    ApiFutebolService.new.atualiza_campeonatos!
  end
end
