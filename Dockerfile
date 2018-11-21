FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y curl build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs
RUN mkdir /admission_api
WORKDIR /admission_api
COPY Gemfile /admission_api/Gemfile
COPY Gemfile.lock /admission_api/Gemfile.lock
RUN bundle install
COPY . /admission_api
