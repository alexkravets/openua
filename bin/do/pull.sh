#!/bin/sh

su rails
cd "$HOME/openua"

source "$HOME/env"
source /etc/profile.d/rvm.sh

git pull
bundle install
RAILS_ENV=production bin/rails assets:precompile

exit
restart puma-manager