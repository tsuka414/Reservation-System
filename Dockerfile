FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV APP_HOME /household_account_on_rails

RUN mkdir ${APP_HOME}
WORKDIR ${APP_HOME}

ADD Gemfile ${APP_HOME}/Gemfile
ADD Gemfile.lock ${APP_HOME}/Gemfile.lock

RUN bundle install
ADD . ${APP_HOME}

# コンテナ起動時に毎回実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# サーバーの起動
CMD ["rails", "server", "-b", "0.0.0.0"]