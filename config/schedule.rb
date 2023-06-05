set :output, "#{path}/log/cron.log"

set :environment, 'development'

every 1.minute do
  rake "atualiza_campeonatos:atualiza"
end