#!/bin/sh

bundle install
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails server