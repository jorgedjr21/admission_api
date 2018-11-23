FROM ruby:2.5
#GETTING REPOS TO INSTALL NPM AND YARN
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
 #INSTALLING ESSENTIALS
RUN apt-get update -qq && apt-get install -y curl build-essential libpq-dev
RUN apt-get install -y nodejs yarn locales wget \
    && rm -rf /var/lib/apt/lists/*

#SETTING ENVIRONMENT TIMEZONE AND LANGUAGE
RUN echo "America/Sao_Paulo" > /etc/timezone && \
  dpkg-reconfigure -f noninteractive tzdata && \
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
  echo 'LANG="pt_BR.UTF-8"'>/etc/default/locale && \
  echo 'LC_ALL="pt_BR.UTF-8"'>/etc/default/locale && \
  echo 'LANGUAGE="pt_BR.UTF-8"'>/etc/default/locale && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=pt_BR.UTF-8

ENV LC_ALL=pt_BR.UTF-8
ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR.UTF-8

#CONFIG CONTAINER ENVIRONMENT
RUN mkdir /admission_api
WORKDIR /admission_api
COPY Gemfile /admission_api/Gemfile
COPY Gemfile.lock /admission_api/Gemfile.lock
RUN bundle install
COPY . /admission_api
