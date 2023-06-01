# !/bin/sh
rails db:drop && \
  rails db:reset && \
  rails db:migrate && \
  rails db:seed