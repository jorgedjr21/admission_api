FROM ruby:2.5
#GETTING REPOS TO INSTALL NPM AND YARN
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
 #INSTALLING ESSENTIALS
RUN apt-get update -qq && apt-get install -y curl build-essential libpq-dev
RUN apt-get install -y nodejs yarn
#CONFIG CONTAINER ENVIRONMENT
RUN mkdir /admission_api
WORKDIR /admission_api
COPY Gemfile /admission_api/Gemfile
COPY Gemfile.lock /admission_api/Gemfile.lock
RUN bundle install
COPY . /admission_api
