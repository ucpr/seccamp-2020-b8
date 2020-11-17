#!/bin/sh

sleep 10
bundle exec rails db:create db:migrate
sleep 200

#bundle exec rails server
