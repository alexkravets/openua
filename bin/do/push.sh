#!/bin/sh

if [ "$*" == "" ]; then
  echo "Please provide server host/ip, see: https://cloud.digitalocean.com/droplets"
  exit 1
fi

HOST="$1"
ssh root@$HOST "bash -s" < ./bin/do/pull.sh
