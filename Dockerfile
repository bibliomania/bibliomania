FROM ruby:2.4.1

ENV APP_ROOT /var/app

WORKDIR $APP_ROOT
EXPOSE 3000

RUN apt-get update && apt-get install -y \
      nodejs \
      mysql-client \
      sqlite3 \
      --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT
RUN bundle install

COPY . $APP_ROOT

#CMD ["rails", "server", "-b", "0.0.0.0"]
