FROM ruby:2.7.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

RUN mkdir /kintai

# 作業ディレクトリを/kintaiに指定
WORKDIR /kintai

# ローカルのGemfileをDokcerにコピー
COPY Gemfile* /kintai/

# /kintaiディレクトリ上でbundle install
RUN bundle install

ADD . /kintai