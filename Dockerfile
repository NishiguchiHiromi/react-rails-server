FROM ruby:2.6

ENV LANG C.UTF-8

RUN mkdir -p /server
WORKDIR /server

RUN apt-get update && \
    apt-get install -y \
      npm \
      default-mysql-client \
      vim \
      unzip \
      imagemagick \
      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash

RUN apt-get install nodejs -y
RUN npm install -g yarn

RUN gem install bundler
COPY Gemfile /server/Gemfile
COPY Gemfile.lock /server/Gemfile.lock
RUN bundle install
COPY . /server

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x scripts/setup.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["scripts/setup.sh"]


# FROM ruby:2.6
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#     && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#     && apt-get update -qq \
#     && apt-get install -y nodejs yarn \
#     && mkdir /server
# WORKDIR /server
# COPY Gemfile /server/Gemfile
# COPY Gemfile.lock /server/Gemfile.lock
# RUN gem install bundler
# RUN bundle install
# COPY . /server

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# CMD ["bundle", "exec", "rails", "server"]