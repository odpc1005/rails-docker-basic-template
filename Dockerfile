FROM ruby:2.7 
LABEL maintainer="odpc"
# allow https sources
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends  apt-transport-https
# install node
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs 
# latest packages of yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# Install packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs yarn
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app 
RUN bundle install 
COPY . /usr/src/app/
CMD ["bin/rails", "s", "-b","0.0.0.0"]
