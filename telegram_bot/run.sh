#!/bin/bash

TOKEN="$(cat /var/secrets/telegram_bot/token.txt)"
CNAME=telegram_bot
INAME=docker.heinrichhartmann.net:5000/telegram_bot:latest

docker stop $CNAME
docker rm $CNAME
docker pull $INAME
docker run -d --restart unless-stopped --name $CNAME \
       -e TOKEN=$TOKEN \
       -v /share/hhartmann/attic/Stack:/work/dl \
       $INAME \
       bash -c '
while true
do
  printf "pull %s\n" $(date +"%FT%T%Z")
  telegram_bot pull $TOKEN
  sleep 60
done
'

echo "Watch logs after restart. CTRL-C when done"
set -x
docker logs -f telegram_bot
