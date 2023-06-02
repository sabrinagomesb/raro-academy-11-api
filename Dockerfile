FROM ruby:3.0.3
ENV LANG C.UTF-8
RUN apt update && apt install -y cron
RUN gem install bundler --version "2.4.5"
WORKDIR /app
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
# just making bundle install work
ADD ./vendor vendor
RUN bundle
COPY . .
EXPOSE 3000
RUN chmod +x entrypoint.sh
RUN touch /etc/crontab /etc/cron.*/*
CMD [ "/bin/sh", "entrypoint.sh" ]
