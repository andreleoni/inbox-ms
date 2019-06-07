FROM ruby:2.5.1-alpine3.7

RUN apk --update add nodejs postgresql-dev libxml2

RUN apk --update add --virtual build-dependencies make g++

RUN apk add --no-cache bash

RUN apk add --no-cache curl

RUN mkdir /inbox

WORKDIR /inbox

COPY Gemfile /inbox/Gemfile

COPY Gemfile.lock /inbox/Gemfile.lock

RUN gem update bundle

RUN bundle install

COPY . /inbox

EXPOSE 3001

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
