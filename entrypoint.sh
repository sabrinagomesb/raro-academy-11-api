# !/bin/sh
rails db:migrate
rails db:seed

whenever --update-crontab

rails server -b 0.0.0.0