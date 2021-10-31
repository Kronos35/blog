#!/bin/bash

set -e

bundle check || bundle install

rm -f tmp/pids/server.pid

# bundle exec rake db:reset

/bin/bash
